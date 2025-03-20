ESX = exports["es_extended"]:getSharedObject()

--Check if Plate taken--
ESX.RegisterServerCallback('unknown:getplate', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)
----------------------


--Give Car--
RegisterServerEvent('unknown:givecar', function (id, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(id)
	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored, type) VALUES (@owner, @plate, @vehicle, @stored, @type)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@stored']  = 1,
		['type'] = "car"
	}, function ()
        xPlayer.showNotification('Du hast das Auto mit dem Kennzeichen: ' ..vehicleProps.plate.. " erhalten!")
	end)
end)
-----------------------