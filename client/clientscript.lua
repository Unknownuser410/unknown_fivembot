ESX = exports["es_extended"]:getSharedObject()

--Kill--
RegisterNetEvent("bot:kill", function()
    SetEntityHealth(PlayerPedId(), 0)
end)
------------------


--Heal--
RegisterNetEvent("bot:heal", function()
    SetEntityHealth(PlayerPedId(), 200)
end)
------------


--Givecar--
RegisterNetEvent('unknown:spawncar', function(car)
	local playerPed = GetPlayerPed(-1)
	local coords = GetEntityCoords(playerPed)
    local spawn = vector3(coords.x, coords.y, coords.z - 30.0)

	ESX.Game.SpawnVehicle(car, spawn, 0.0, function(vehicle) --get vehicle info
		if DoesEntityExist(vehicle) then
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			
			local newPlate     = GeneratePlate()
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
            local model = GetEntityModel(vehicle)
			TriggerServerEvent('unknown:givecar', GetPlayerServerId(PlayerId()), vehicleProps)
			DeleteEntity(vehicle)
		end		
	end)
end)
---------------


--Utils from esx_vehicleshop--
local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		generatedPlate = string.upper(GetRandomLetter(3) .. GetRandomNumber(3))

		ESX.TriggerServerCallback('unknown:getplate', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end
------------------------