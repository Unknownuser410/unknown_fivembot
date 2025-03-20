fx_version "cerulean"
game "gta5" 

author "Unknown_user410"
description "Discordbot für Interaktionen mit FiveM"
version "1.0.0"

client_scripts {
    "client/clientscript.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config.lua",
    "api/discordapi.lua",
    "api/functions.lua",
    "server/script.lua",
    "commands/command.lua",
}