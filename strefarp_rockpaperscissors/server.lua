ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('explo_papier:zacznij')
AddEventHandler('explo_papier:zacznij', function(closestPlayer, price)
	_source = source
    target = ESX.GetPlayerFromId(closestPlayer)
	argument2 = price
	print(argument2)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('pkn:start', target.source, price, _source)
    end)

RegisterServerEvent('zagrano:pkn')
AddEventHandler('zagrano:pkn', function(source, arg1, argument3)

TriggerClientEvent('strefarp:wyswietl', -1, "Pokazuje: "..arg1, target.source)
TriggerClientEvent('strefarp:wyswietl2', -1, "Pokazuje: "..argument2, source)
end)
 