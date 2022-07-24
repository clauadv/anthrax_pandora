const file_system = require("fs");
const async = require("async");
const performance = require('perf_hooks').performance;

var files = [
    // hooked
    "cstrike/libraries/hooked.lua",

    // render
    "cstrike/render/render.lua",

    // globals
    "cstrike/globals/globals.lua",

    // math
    "cstrike/math/math.lua",

    // libraries
    "cstrike/libraries/entity.lua",
    "cstrike/libraries/weapon.lua",
    "cstrike/libraries/base64.lua",
    "cstrike/libraries/json.lua",
    "cstrike/libraries/http.lua",

    // utils
    "cstrike/utils/utils.lua",

    // menu
    "cstrike/menu/menu.lua",

    // features
    "cstrike/features/rage.lua",
    "cstrike/features/antiaim.lua",
    "cstrike/features/dynamic_antiaim.lua",
    "cstrike/features/visuals.lua",
    "cstrike/features/misc.lua",
    "cstrike/features/config.lua",

    // callbacks
    "cstrike/callbacks/paint.lua",
    "cstrike/callbacks/post_move.lua",
    "cstrike/callbacks/post_anim_update.lua"
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