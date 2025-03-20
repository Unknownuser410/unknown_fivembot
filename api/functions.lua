--Send MSG to console--
function sendcmd(msg,type)
    if type == "error" then 
        print("[^1ERROR^0] " ..msg)
    elseif type == "success" then 
        print("[^2SUCCESS^0] " ..msg)
    end
end
---------------------------


--Get Discord ID--
function GetDiscordId(src)
    local discordid = nil
    
    if type(src) == "string" then --Give Discordid instead of src
        return src 
    end

    for _, v in pairs(GetPlayerIdentifiers(src)) do
        if string.find(v, "discord:") then
            discordid = v:gsub('discord:', '')
        end
    end

    return discordid
end
---------------------------


--Send Discord MSG--
function senddiscordmsg(title, msg, type, author)
    local endpoint = ("channels/%s/messages"):format(Botchannel)
    local result = DiscordRequest(endpoint, "POST", {
        ["embeds"] = {
            {
                ["title"] = title or "Neue Nachricht",
                ["description"] = "```" ..msg.."```",
			    ["color"] = Config.Messagetypes[type] or 0,
                ["fields"] = {
                    {
                      ["name"] = "**Angefragt von: **",
                      ["value"] = "<@" ..author..">",
                    },
                },
			    ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%SZ'),
            }
        }
    })
    
    if not result or result.code ~= 200 then 
        sendcmd("Nachricht konnte nicht gesendet werden!", "error")
    end

    return json.decode(result.data).id
end
----------------------


--Send Discord DM MSG--
function senddiscorddmmsg(src, title, msg, type, author)
    local discordid = GetDiscordId(src)
    local channel = DiscordRequest("/users/@me/channels", "POST", {
        ["recipient_id"] = discordid,
    })
    local channelid = json.decode(channel.data).id

    local msgresult = DiscordRequest(("channels/%s/messages"):format(channelid), "POST", {
        ["embeds"] = {
            {
                ["title"] = title or "Neue Nachricht",
                ["color"] = Config.Messagetypes[type] or 0,
                ["description"] = "```" ..msg.."```",
                ["fields"] = {
                    {
                      ["name"] = "**Angefragt von: **",
                      ["value"] = "<@" ..author..">",
                    },
                },
			    ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%SZ'),
            }
        }
    })
    
    if msgresult.code ~= 200 then 
        sendcmd("DM Nachricht konnte nicht gesendet werden!", "error")
    end
end
----------------------


--Get All Player Roles--
function getRoles(src)
    local discordid = GetDiscordId(src)

    local endpoint = ("guilds/%s/members/%s"):format(GuildID, discordid)
    local result = DiscordRequest(endpoint, "GET", {})
    if result.code ~= 200 then return {} end

    local data = json.decode(result.data).roles
    for key, id in pairs(data) do 
        for name, roleid in pairs(DiscordRoles) do 
            if tonumber(id) == tonumber(roleid) then 
                data[key] = name
            end
        end
    end

    return data
end
-------------------------


--Get specific Role--
function checkifhasrole(src, rolename)
    local discordid = GetDiscordId(src)

    local endpoint = ("guilds/%s/members/%s"):format(GuildID, discordid)
    local result = DiscordRequest(endpoint, "GET", {})
    if result.code ~= 200 then return false end

    local data = json.decode(result.data)
    local role = DiscordRoles[tostring(rolename)]

    for k, v in pairs(data.roles) do
        if v == role then
            return true
        end
    end

    return false
end
-------------------------


--Split Command in Args--
function stringsplit(inputstr)
    local args = {}

    for str in string.gmatch(inputstr, "([^%s]+)") do
      table.insert(args, str)
    end
    
    return args
end
-----------------------
  

--Check if ID is online--
function checkifonline(src)
    return DoesPlayerExist(src)
end
-----------------------


--Version Check--
Citizen.CreateThread(function()
    local resourceName = GetCurrentResourceName()
    local currentVersion = GetResourceMetadata(resourceName, 'version', 0)

    PerformHttpRequest('https://api.github.com/repos/Unknownuser410/unknown_fivembot/releases/latest', function(error, result, headers)
        if error == 200 then
            local data = json.decode(result)  -- JSON antwort decodieren
            local latestVersion = data.tag_name  -- Die neueste Version vom GitHub Release
            local changelog = data.body or ""
            latestVersion = latestVersion:match("^v?(.*)") -- Entferne das 'v' von der GitHub-Version, falls vorhanden
            changelog = changelog:gsub("#", "") -- Entferne das '#' vom Changelog, falls vorhanden

            if latestVersion ~= currentVersion then
                print("Es gibt eine neue Version! ^1Aktuelle Version: " ..currentVersion.. "^0 | ^2Neueste Version: " ..latestVersion.."^0", "\n^2Changelog:^0\n" ..changelog)
            end
        else
            print("Fehler beim Abrufen der GitHub-Daten: " .. error)
        end
    end, 'GET')
end)
---------------------