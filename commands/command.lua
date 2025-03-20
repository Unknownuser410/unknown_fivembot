-- Commands--
function commandexecuted(data, userid)
    local command = data[1] 
    local player = data[2]
 
    --Test Command--
    if command == "test" then 
        if checkifhasrole(userid, "Team") then
            senddiscordmsg("Command Erkannt!", "Test Command ausgeführt!", "success", userid)
            senddiscorddmmsg(userid, "Command Erkannt!", "Test Command ausgeführt!", "success", userid)
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Kill Player--
    elseif command == "kill" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                TriggerClientEvent("bot:kill", player)
                senddiscordmsg("Spieler getötet!", "Der Spieler (" ..GetPlayerName(player).. ") wurde getötet", "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Revive--
    elseif command == "revive" then 
        if checkifhasrole(userid, "Team") then
            if checkifonline(player) then
                TriggerClientEvent("esx_ambulancejob:revive", player)
                senddiscordmsg("Spieler wiederbelebt!", "Der Spieler (" ..GetPlayerName(player).. ") wurde wiederbelebt", "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    elseif command == "reviveall" then 
        if checkifhasrole(userid, "Team") then
            local players = GetPlayers()
            if #players > 0 then
                TriggerClientEvent("esx_ambulancejob:revive", -1)
                senddiscordmsg("Spieler wiederbelebt!", "Alle Spieler wurden wiederbelebt", "success", userid)
            else
                senddiscordmsg("Offline", "Es sind keine Spieler online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Heal--
    elseif command == "heal" then 
        if checkifhasrole(userid, "Team") then
            if checkifonline(player) then
                TriggerClientEvent("bot:heal", player)
                senddiscordmsg("Spieler geheilt!", "Der Spieler (" ..GetPlayerName(player).. ") wurde geheilt", "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end


    --Status--
    elseif command == "status" then 
        if checkifhasrole(userid, "Team") then
            local players = GetPlayers()
            if #players > 0 then
                local text = ""
                for _, id in pairs(players) do 
                    text = text.. "\n["..id.."] " ..GetPlayerName(id)
                end
                senddiscordmsg("Spielerliste [" ..#players.."/"..GetConvar("sv_maxclients", 32).."]", text, "success", userid)
            else
                senddiscordmsg("Offline", "Es sind keine Spieler online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Spielerinfo--
    elseif command == "info" then 
        if checkifhasrole(userid, "Team") then

            if not player then 
                senddiscordmsg("Daten fehlen!", "Gib eine Spieler ID an!", "error", userid)
                return 
            end

            if checkifonline(player) then
                local xPlayer = ESX.GetPlayerFromId(player)
                local text = "[Name] = " ..xPlayer.getName().. "\n[Geburtstag] = " ..xPlayer.variables.dateofbirth.. "\n[Geschlecht] = " ..xPlayer.variables.sex.. "\n[Gruppe] = " ..xPlayer.group.. "\n[Job] = " ..xPlayer.job.label.. " | " ..xPlayer.job.grade_label.. "\n[Bargeld] = " ..xPlayer.getAccount('money').money.. "\n[Bank] = " ..xPlayer.getAccount('bank').money.. "\n[Schwarzgeld] = " ..xPlayer.getAccount('black_money').money
                senddiscordmsg("Spieler Informationen (" ..GetPlayerName(player)..")", text, "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --DM Player--
    elseif command == "dm" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                local xPlayer = ESX.GetPlayerFromId(player)
                local text = ""

                for i = 1, #data do 
                    if i > 2 then 
                        text = text.. " " ..data[i]
                    end
                end

                xPlayer.showNotification(text)
                senddiscordmsg("Spieler DM", "Der Spieler (" ..GetPlayerName(player).. ") bekam folgende Nachricht:\n-" ..text, "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Kick Player--
    elseif command == "kick" then 
        if checkifhasrole(userid, "Team") then
            if checkifonline(player) then
                local text = ""

                for i = 1, #data do 
                    if i > 2 then 
                        text = text.. " " ..data[i]
                    end
                end

                senddiscordmsg("Spieler gekickt!", "Der Spieler (" ..GetPlayerName(player).. ") wurde mit folgendem Grund gekickt:\n-" ..text, "success", userid)
                DropPlayer(player, text)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Give Item--
    elseif command == "giveitem" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                if not data[3] or not data[4] then 
                    senddiscordmsg("Daten fehlen!", "Gib einen Itemnamen und eine Anzahl an!", "error", userid)
                    return 
                end

                local xPlayer = ESX.GetPlayerFromId(player)
                xPlayer.addInventoryItem(data[3], tonumber(data[4]))
                senddiscordmsg("Item hinzugefügt!", "Der Spieler (" ..GetPlayerName(player).. ") bekam folgendes Item:\n- " ..data[4].. "x " ..data[3], "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Remove Item--
    elseif command == "removeitem" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                if not data[3] or not data[4] then 
                    senddiscordmsg("Daten fehlen!", "Gib einen Itemnamen und eine Anzahl an!", "error", userid)
                    return 
                end

                local xPlayer = ESX.GetPlayerFromId(player)
                local amount = tonumber(data[4])
                local hasamount = xPlayer.getInventoryItem(data[3]).count
                if amount > hasamount then 
                    amount = hasamount
                end
                xPlayer.removeInventoryItem(data[3], amount)
                senddiscordmsg("Item entfernt!", "Der Spieler (" ..GetPlayerName(player).. ") bekam folgendes Item entfernt:\n- " ..amount.. "x " ..data[3], "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Clear Inventory--
    elseif command == "clearinv" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                local xPlayer = ESX.GetPlayerFromId(player)
                
                --Items--
                for _, item in pairs(xPlayer.getInventory()) do 
                    xPlayer.removeInventoryItem(item.name, item.count)
                end

                --Waffen--
                for _, weapon in pairs(xPlayer.getLoadout()) do
                    xPlayer.removeWeapon(weapon.name)
                end  

                senddiscordmsg("Items entfernt!", "Das Inventar des Spielers (" ..GetPlayerName(player).. ") wurde gelöscht!", "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Set Job--
    elseif command == "setjob" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                if not data[3] or not data[4] then 
                    senddiscordmsg("Daten fehlen!", "Gib einen Job und einen Rang ein!", "error", userid)
                    return 
                end

                local xPlayer = ESX.GetPlayerFromId(player)
                xPlayer.setJob(data[3], tonumber(data[4]))
                Wait(100)
                senddiscordmsg("Job gesetzt!", "Der Spieler (" ..GetPlayerName(player).. ") bekam folgenden Job:\n- " ..xPlayer.getJob().label.. " | " ..xPlayer.getJob().grade_label, "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Set Group--
    elseif command == "setgroup" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                if not data[3] then 
                    senddiscordmsg("Daten fehlen!", "Gib eine Rolle an!", "error", userid)
                    return 
                end

                local xPlayer = ESX.GetPlayerFromId(player)
                local alterole = xPlayer.getGroup() 
                xPlayer.setGroup(data[3])
                Wait(100)
                senddiscordmsg("Gruppe gesetzt!", "Der Spieler (" ..GetPlayerName(player).. ") bekam folgendes:\nAlte Gruppe: " ..alterole.. "\nNeue Gruppe: " ..xPlayer.getGroup(), "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Set Name--
    elseif command == "setname" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                if not data[3] or not data [4] or #data > 4 then 
                    senddiscordmsg("Daten fehlen!", "Gib einen Namen mit einem Vor und Nachnamen, nicht mehr und nicht weniger!", "error", userid)
                    return 
                end

                local xPlayer = ESX.GetPlayerFromId(player)
                local altername = xPlayer.getName() 
                xPlayer.setName(data[3] .." " ..data[4])
                Wait(100)
                senddiscordmsg("Name gesetzt!", "Der Spieler (" ..GetPlayerName(player).. ") bekam folgenden Namen:\nAlter Name: " ..altername.. "\nNeuer Name: " ..xPlayer.getName(), "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Give Money--
    elseif command == "givemoney" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                if not data[3] or not data[4] then 
                    senddiscordmsg("Daten fehlen!", "Gib einen Typ und einen Betrag ein!", "error", userid)
                    return 
                elseif data[3] ~= "money" and data[3] ~= "bank" and data[3] ~= "black_money" then
                    senddiscordmsg("Daten fehlen!", "Unbekannter Kontotyp!", "error", userid)
                    return  
                end

                local xPlayer = ESX.GetPlayerFromId(player)
                local oldmoney = xPlayer.getAccount(data[3]).money
                xPlayer.addAccountMoney(data[3], tonumber(data[4]))
                senddiscordmsg("Geld gegeben!", "Der Spieler (" ..GetPlayerName(player).. ") bekam folgendes:\nAccount (" ..data[3].. ") + " ..data[4].. "$ \nAlter Stand: " ..oldmoney.. "\nNeuer Stand: " ..xPlayer.getAccount(data[3]).money, "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Remove Money--
    elseif command == "removemoney" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                if not data[3] or not data[4] then 
                    senddiscordmsg("Daten fehlen!", "Gib einen Typ und einen Betrag ein!", "error", userid)
                    return 
                elseif data[3] ~= "money" and data[3] ~= "bank" and data[3] ~= "black_money" then
                    senddiscordmsg("Daten fehlen!", "Unbekannter Kontotyp!", "error", userid)
                    return  
                end

                local xPlayer = ESX.GetPlayerFromId(player)
                local oldmoney = xPlayer.getAccount(data[3]).money
                xPlayer.removeAccountMoney(data[3], tonumber(data[4]))
                senddiscordmsg("Geld gegeben!", "Der Spieler (" ..GetPlayerName(player).. ") bekam folgendes:\nAccount (" ..data[3].. ") - " ..data[4].. "$ \nAlter Stand: " ..oldmoney.. "\nNeuer Stand: " ..xPlayer.getAccount(data[3]).money, "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Delete Car--
    elseif command == "dv" then 
        if checkifhasrole(userid, "Team") then
            local cars = GetAllVehicles()
            local found = false

            for _, car in pairs(cars) do 
                if string.find(GetVehicleNumberPlateText(car), player) then 
                    DeleteEntity(car)
                    found = true 
                    break
                end
            end

            if found then
                senddiscordmsg("Fahrzeug gelöscht!", "Das Fahrzeug mit dem Kennzeichen (" ..player.. ") wurde gelöscht!", "success", userid)
            else
                senddiscordmsg("Kein Fahrzeug!", "Es wurde kein Fahrzeug mit dem Kennzeichen (" ..player.. ") gefunden!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Spawn Car--
    elseif command == "car" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                if not data[3] then 
                    senddiscordmsg("Daten fehlen!", "Gib einen Fahrzeugnamen ein!", "error", userid)
                    return 
                end

                local ped = GetPlayerPed(player)
                local car = CreateVehicle(data[3], GetEntityCoords(ped), GetEntityHeading(ped), true, false)
                Wait(100)
                TaskWarpPedIntoVehicle(ped,car, -1)
                
                senddiscordmsg("Fahrzeug gespawned!", "Der Spieler (" ..GetPlayerName(player).. ") bekam temporär folgendes Fahrzeug:\n"..data[3], "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end

    --Give Car--
    elseif command == "givecar" then 
        if checkifhasrole(userid, "Highteam") then
            if checkifonline(player) then
                if not data[3] then 
                    senddiscordmsg("Daten fehlen!", "Gib einen Fahrzeugnamen ein!", "error", userid)
                    return 
                end

                TriggerClientEvent("unknown:spawncar", player, data[3])
                
                senddiscordmsg("Fahrzeug eingefügt!", "Der Spieler (" ..GetPlayerName(player).. ") bekam folgendes Fahrzeug:\n"..data[3], "success", userid)
            else
                senddiscordmsg("Spieler nicht Online", "Es ist kein Spieler mit dieser ID online!", "error", userid)
            end
        else
            senddiscordmsg("Unberechtigt!", "Dir fehlt die nötige Rolle für diesen Command!", "error", userid)
        end    
        
    --Command Unbekannt--
    else
        senddiscordmsg("Fehler", "Dieser Command ist nicht registriert!", "error", userid)
    end
end
-------------------------------------