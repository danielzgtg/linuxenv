console.log($$(".mw-changeslist-date").map(x=>/\d+$/.exec(x.href)[0]).join("\n"))
