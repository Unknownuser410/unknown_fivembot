token = "Bot " .. Config.DiscordToken
GuildID = Config.GuildID
DiscordRoles = Config.DiscordRoles
Botchannel = Config.ChannelID
Prefix = Config.Prefix
local botid = nil

--Send Request to API--
function DiscordRequest(endpoint, method, jsondata)
    local data = nil
    local timer = 0

    PerformHttpRequest("https://discord.com/api/" .. endpoint, function(codeResponse, dataResponse, headersResponse)
        data = {
            code = codeResponse,
            data = dataResponse,
            headers = headersResponse
        }
    end, method, ((next(jsondata) and json.encode(jsondata)) or ""),
    {
        ["Content-Type"] = "application/json",
        ["Authorization"] = token
    })

    while data == nil and timer < 50 do
        Wait(100)
        timer = timer + 1
    end

    if not data then 
        sendcmd("Anfrage gab keine Daten innerhalb der Zeit zurück!", "error")
        sendcmd(endpoint, "error")
        sendcmd(method, "error")
    end

    return data
end
------------------------------


--Check if prefix--
function string.starts(String, Start)
    return string.sub(String,1,string.len(Start))==Start
end
--------------------


--Start Bot and listen for prefix messages--
Citizen.CreateThread(function()
    Wait(100) --Load all files

    --Discord Server abfragen--
    local guild = DiscordRequest("guilds/" .. GuildID, "GET", {})

    if guild.code ~= 200 then
        sendcmd("Deine Guild ID gab einen Fehler Code!", "error")
        return
    end

    local data = json.decode(guild.data)
    sendcmd("Server erkannt! Name: " ..data.name.. " ID: " ..data.id, "success")
    ------------------------------


    --Load Name and Bot ID--
    local name = DiscordRequest("/users/@me", "PATCH", {
        ["username"] = Config.Botname,
    })
    local bot = DiscordRequest("/users/@me", "GET", {})
    botid = json.decode(bot.data).id
    -------------------


    --Send Channel MSG on Start--
    local startmsg = senddiscordmsg("Online", "Der Bot wurde gestartet!", "success", botid)
    Wait(100)
    -------------------------


    --Wait for Commands to operate--
    while true do
        local messages = DiscordRequest(("channels/%s/messages?after=%s"):format(Botchannel, startmsg), "GET", {})

        if messages and messages.data then
            for _, data in pairs(json.decode(messages.data)) do 
                if string.starts(data.content, Prefix) then 
                    --Set new start Message--
                    startmsg = data.id

                    --Execute--
                    commandexecuted(stringsplit(data.content:gsub(Prefix, '')), data.author.id)
                end
            end
        end
        Wait(500) --Never go below 100
    end
end)