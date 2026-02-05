#!/usr/bin/env node
// Go to https://stackexchange.com/ , click on your profile picture,
// then copy the number in the URL here
const stackexchange_com_userid = "14505422";

let notifier;
const title = "Stack Exchange notify-send";
console.log(title + ": https://stackapps.com/q/11981/121649");
if (process.platform === "linux") { // Dependencyless on Linux
    const { spawn } = require("child_process");
    // https://reddit.com/r/kde/comments/if5oeb/notifications_from_script_not_saving_to_history/g2lvzvj/
    const persist = ["-h", "string:desktop-entry:org.kde.konsole"];
    // libnotify-bin is default-installed on Ubuntu. Please install it if missing in other distros
    notifier = message => void spawn("notify-send", [...persist, title, message], { stdio: "inherit" });
} else {
    const { notify } = require("node-notifier");
    notifier = message => void notify({ title, message });
}

// Surprising no authentication's required.
const s = new WebSocket("wss://qa.sockets.stackexchange.com"); // https://meta.stackexchange.com/q/218343/1373352
s.onmessage = e => {
    data = JSON.parse(e.data)
    console.log(e.data);
    if (data.action === "hb") {
        s.send("pong");
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
    console.log("Connected. Now waiting for inbox messages or reputation changes...");
};
