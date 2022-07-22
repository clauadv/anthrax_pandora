const file_system = require("fs");
const async = require("async");
const performance = require('perf_hooks').performance;

var files = [
    // render
    "cstrike/render/render.lua",

    // globals
    "cstrike/globals/globals.lua",

    // math
    "cstrike/math/math.lua",

    // libraries
    "cstrike/libraries/entity.lua",

    // callbacks
    "cstrike/callbacks/paint.lua",
    "cstrike/callbacks/post_move.lua"
];

var stored_data = [];
async.map(files, file_system.readFile, (error, files) => {
    if (error) throw error;

    files.forEach((data) => {
        stored_data += data.toString() + "\n";
    });

    file_system.writeFile("E:/Steam Library/steamapps/common/Counter-Strike Global Offensive/Pandora/lua/anthrax_pandora.lua", stored_data, (error) => {
        if (error) throw error;

        console.log(`\n[*] built in ${performance.now().toFixed(0)}ms`);
    });
});