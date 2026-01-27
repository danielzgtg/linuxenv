#!/usr/bin/env node
const fs = require("fs");
const process = require("process");

if (process.argv.length !== 2) {
    throw Error("Usage: ./archive.js");
}
const data = JSON.parse(fs.readFileSync("stylus.json"));
console.log(data.length);

for (const userstyle of data.slice(1)) {
    const {name, sections} = userstyle;
    if (/[\0/\\]|\.\./.test(name) || name.startsWith(".")) {
        throw Error("Directory traversal attack");
    }
    console.log(name);
    if (userstyle?._usw?.token) {
        throw Errror("Token leak");
    }
    sections.forEach((section, i) => {
        const cssPath = `${name}.${i}.css`;
        console.log(cssPath);
        section.code = fs.readFileSync(cssPath, "utf-8").trimEnd();
    });
}

console.log("stylus_import.json");
fs.writeFileSync("stylus_import.json", JSON.stringify(data, void 0, 2));
console.log("OK");
