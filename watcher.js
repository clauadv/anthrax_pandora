const fs = require('fs');
const { exec } = require('child_process');

let wait = false;
fs.watch("D:/GitHub/anthrax_pandora/", { recursive: true }, (event, name) => {
    if (wait) return;

    wait = setTimeout(() => {
        wait = false;
    }, 100);

    exec("node build.js", (error, out) => {
        if (error) return;

        console.log(out);
    });
});