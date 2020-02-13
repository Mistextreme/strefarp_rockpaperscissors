local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}
local color = {r = 153, g = 51, b = 153, alpha = 255} -- Color of the text 
local font = 4 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local nbrDisplaying = 0
local chatMessage = true
ESX                           = nil
local source1				  = ' '
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(0)
	end

	PlayerData = ESX.GetPlayerData()
end)


RegisterCommand('pkn', function(source, args)
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()
	id = GetPlayerServerId(closestPlayer)
    local argument = table.unpack(args)
	local poprawny = false
		if argument == 'papier' or argument == 'Papier' or argument == 'kamien' or argument == 'Kamien' or argument == 'nozyce' or argument == 'Nozyce' or argument == 'kamień' or argument == 'Kamień' or argument == 'Nożyce' or argument == 'nożyce' then
			if distance ~= -1 and distance <= 2 then
				if argument ~= nil then
					TriggerServerEvent('explo_papier:zacznij', id, argument)
					ESX.ShowNotification('~g~Rzucono Wyzwanie graczowi: ~b~'..id)
				else
					ESX.ShowNotification('~r~Nie prawidłowy argument')
				end
			else
				ESX.ShowNotification('~r~Nie ma nikogo w pobliżu')
			end
		else
		ESX.ShowNotification('~r~Poprawny argument to: ~b~Papier/Kamien/Nozyce')
		end
end, false) 

RegisterNetEvent('pkn:start')
AddEventHandler('pkn:start', function(id, argument, source1)

    local DoingDeal = true
	local argument2 = ' '

    Citizen.CreateThread(function()
        while DoingDeal do
            Citizen.Wait(1)

            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			ESX.ShowNotification('~g~Dostałeś wyzwanie w ~b~Papier-Kamien-Nozyce!')
            ESX.ShowNotification('~g~[E] Papier ~b~[H] Kamien            ~r~[K] Nozyce')
            if IsControlJustReleased(0, Keys['E']) then
				argument2 = 'papier'
                TriggerServerEvent('zagrano:pkn', argument, argument2)
                DoingDeal = false
			elseif IsControlJustReleased(0, Keys['H']) then
				argument2 = 'kamien'
                TriggerServerEvent('zagrano:pkn', argument, argument2)
                DoingDeal = false
            elseif IsControlJustReleased(0, Keys['K']) then
				argument2 = 'nozyce'
                TriggerServerEvent('zagrano:pkn', argument, argument2)
                DoingDeal = false
              end
        end
    end)

end)

RegisterNetEvent('strefarp:wyswietl2')
AddEventHandler('strefarp:wyswietl2', function(text, source)
    local offset = 1 + (nbrDisplaying*0.14)
    Display2(GetPlayerFromServerId(source), text, offset)
end)

function Display2(mePlayer, text, offset)
    local displaying = true
     -- Chat message
     if chatMessage then
        local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local coords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist2(coordsMe, coords)
        
    end
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
            DrawText3D2(coords['x'], coords['y'], coords['z']+offset, text)
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

RegisterNetEvent('strefarp:wyswietl')
AddEventHandler('strefarp:wyswietl', function(text, source)
    local offset = 1 + (nbrDisplaying*0.14)
    Display(GetPlayerFromServerId(source), text, offset)
end)

function Display(mePlayer, text, offset)
    local displaying = true
     -- Chat message
     if chatMessage then
        local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local coords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist2(coordsMe, coords)
        
    end
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
            DrawText3D(coords['x'], coords['y'], coords['z']+offset, text)
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(22, 24, 145, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end

function DrawText3D2(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(44, 145, 22, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end