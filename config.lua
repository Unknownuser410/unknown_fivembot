Config = {
    DiscordToken = "", -- Bot token
    GuildID = "", -- Server ID 
    ChannelID = "", --Channel des Bots
    Prefix = "!",

    Botname = "Unknown_Bot", --Name des Bots im Discord

    DiscordRoles = {
        ["Highteam"] = "", --Beispiel Rollen
        ["Team"] = "",
    },

    Messagetypes = {
        ["success"] = 5763719, --Discord Farbcode
        ["error"] = 15548997,
    }
}

--Der Bot benötigt folgende Rechte--
--[[
    Presence Intent
    Server Members Intent
    Message Content Intent
]]