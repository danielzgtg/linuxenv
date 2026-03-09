#!/usr/bin/env node
import { promises as fs } from "fs";
import path from "path";
import process from "process";

// Go to https://stackexchange.com/ , click on your profile picture,
// then copy the number in the URL here
const stackexchange_com_userid = "14505422";

let notifier;
// const title = "Stack Exchange notify-send";
// console.log(title + ": https://stackapps.com/q/11981/121649");
const title = "Stack Exchange notify-send PLUS";
console.log(title + ": https://github.com/danielzgtg/linuxenv");
if (process.platform === "linux") { // Dependencyless on Linux
    const { spawn } = await import("child_process");
    // https://reddit.com/r/kde/comments/if5oeb/notifications_from_script_not_saving_to_history/g2lvzvj/
    const persist = ["-h", "string:desktop-entry:org.kde.konsole"];
    // libnotify-bin is default-installed on Ubuntu. Please install it if missing in other distros
    notifier = message => void spawn("notify-send", [...persist, title, message], { stdio: "inherit" });
} else {
    const { notify } = await import("node-notifier");
    notifier = message => void notify({ title, message });
}

const cacheDir = path.join(process.env.HOME, ".cache", "stack-exchange-notify-send-plus");
await fs.mkdir(cacheDir, { recursive: true });
process.chdir(cacheDir);
if (process.platform === "linux") {
    const { spawn } = await import("child_process");
    const flock = spawn("flock", [cacheDir, "-c", "cat"]);
    flock.stdin.write(".");
    await new Promise(resolve => flock.stdout.on("data", () => void resolve()));
} else {
    // Locking not implemented
}
async function cacheFetch(path, url) {
    if (path) {
        let existing = false;
        try {
            await fs.access(path, fs.constants.R_OK);
            existing = true;
        } catch (e) {}
        if (existing) {
            return await fs.readFile(path, "utf-8");
        }
    }
    let fetched = "{}";
    if (url) {
        // console.log("Will fetch: " + url);
        await new Promise(r => setTimeout(r, 100));
        const response = await fetch(url);
        // console.log(response);
        if (response.status !== 200) throw new Error;
        fetched = await response.text();
    }
    if (path && url) {
        await fs.writeFile(path, fetched);
    }
    return fetched;
}

console.log("the Stack Exchange Network is the source of the content provided through the API Services");
const sitesJson = JSON.parse(await cacheFetch("sites.json", "https://api.stackexchange.com/2.3/sites?pagesize=1000")).items;
const hostnameToSiteid = JSON.parse(await cacheFetch("site-list.json", ""));
if (!Object.keys(hostnameToSiteid).length) {
    for (const match of (await cacheFetch("site-list.html", "https://meta.stackexchange.com/topbar/site-switcher/site-list")).replaceAll(/[\n ]+/g, "").matchAll(/href="https:\/\/([^"]+)"data-id="(\d+)"/g)) {
        hostnameToSiteid[match[1]] = +match[2];
    }
    await fs.writeFile("site-list.json", JSON.stringify(hostnameToSiteid) + "\n");
}
const siteidToApiSiteParameter = {};
const apiSiteParameters = process.argv.slice(2);
const apiSiteParametersSet = new Set(apiSiteParameters);
const siteids = [];
for (const siteJson of sitesJson) {
    const { api_site_parameter, site_url } = siteJson;
    if (!site_url.startsWith("https://")) throw new Error;
    if (!apiSiteParametersSet.has(api_site_parameter)) continue;
    const siteid = hostnameToSiteid[site_url.substring(8)];
    if (typeof siteid !== "number") throw new Error;
    siteids.push(siteid);
    siteidToApiSiteParameter[siteid] = api_site_parameter;
    apiSiteParametersSet.delete(api_site_parameter);
}
if (apiSiteParametersSet.size) throw new Error;
const lastCreationDates = JSON.parse(await cacheFetch("last_creation.json", ""));
const waitqueue = [];
function mutexLock() {
    return new Promise(resolve => {
        if (!waitqueue.length) {
            resolve();
        }
        waitqueue.push(resolve);
    });
}
function mutexUnlock() {
    waitqueue.pop()();
}
async function refreshSite(siteid) {
    const api_site_parameter = siteidToApiSiteParameter[siteid];
    let lastCreationDate = lastCreationDates[siteid];
    const questions = JSON.parse(await cacheFetch("", "https://api.stackexchange.com/2.3/questions?order=desc&sort=activity&site=" + api_site_parameter)).items;
    for (let i = questions.length; i--;) {
        const question = questions[i];
        if (question.creation_date <= lastCreationDate) continue;
        lastCreationDate = question.creation_date;
        console.log(api_site_parameter, question.title);
    }
    if (lastCreationDate !== siteidToApiSiteParameter[siteid]) {
        lastCreationDates[siteid] = lastCreationDate;
        await mutexLock();
        await fs.writeFile("last_creation.json", JSON.stringify(lastCreationDates) + "\n");
        mutexUnlock();
    }
}

// Surprising no authentication's required.
const s = new WebSocket("wss://qa.sockets.stackexchange.com"); // https://meta.stackexchange.com/q/218343/1373352
const questionsNewestRe = /^(\d+)-questions-newest$/;
s.onmessage = e => {
    console.log(e.data);
    const data = JSON.parse(e.data);
    if (data.action === "hb") {
        s.send("pong");
        return;
    }
    const siteid = +(questionsNewestRe.exec(data.action) || [])[1];
    if (!isNaN(siteid)) {
        const api_site_parameter = siteidToApiSiteParameter[siteid];
        notifier(`${api_site_parameter}: new question`);
        refreshSite(siteid);
        return;
    }
    notifier(e.data); // Crude but fault-tolerant
    // Omitted filtering out 1 -> 0 upon clicking in browser.
};
s.onopen = () => {
    console.log("Hello https://stackexchange.com/users/" + stackexchange_com_userid)
    // Listen to all of the current user's inbox/reputation notifications across all sites
    // Chat's not targeted by this app except perhaps if a ping enters the inbox
    s.send(stackexchange_com_userid + "-topbar");
    // Listen to new questions
    for (const siteid of siteids) {
        s.send(`${siteid}-questions-newest`);
        refreshSite(siteid);
    }
    console.log("Connected. Now waiting for inbox messages or reputation changes...");
};
