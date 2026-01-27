#!/usr/bin/env node
const fs = require("fs");
const process = require("process");

if (process.argv.length !== 2) {
    throw Error("Usage: ./extract.js");
}
const inputAllFiles = fs.readdirSync(".");
const inputFiles = inputAllFiles.filter(x => /^stylus-.*\.json$/.test(x));
if (inputFiles.length !== 1) {
    throw Error("Need exactly 1 stylus-*.json");
}
const data = JSON.parse(fs.readFileSync(inputFiles[0], "utf-8"));
console.log(data.length);
inputAllFiles.filter(x => x.endsWith(".css")).forEach(x => fs.unlinkSync(x));

for (const userstyle of data.slice(1)) {
    const {name, sections} = userstyle;
    if (/[\0/\\]|\.\./.test(name) || name.startsWith(".")) {
        throw Error("Directory traversal attack");
    }
    console.log(name);
    delete userstyle?._usw?.token;
    sections.forEach((section, i) => {
        const cssPath = `${name}.${i}.css`;
        console.log(cssPath);
        fs.writeFileSync(cssPath, section.code.trimEnd() + "\n");
        delete section.code;
    });
}

console.log("stylus.json");
fs.writeFileSync("stylus.json", JSON.stringify(data, void 0, 2) + "\n");
fs.unlinkSync(inputFiles[0]);
console.log("OK");
