ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        sleep = 2000
        for k in pairs(Config.odunbolge) do
            local ped = PlayerPedId()
            local kordinat = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(kordinat, Config.odunbolge[k].x, Config.odunbolge[k].y, Config.odunbolge[k].z, false)
            if distance < 4 then
                sleep = 2
                DrawMarker(2, Config.odunbolge[k].x, Config.odunbolge[k].y, Config.odunbolge[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 0, 150, 150, 100, 0, 0, 0, 0)
                if distance < 1.40 then
                    DrawText3Ds(Config.odunbolge[k].x, Config.odunbolge[k].y, Config.odunbolge[k].z + 0.5, '[E] Kütük Parçala')
                    if IsControlJustReleased(0, 38) then
                        odunKes()
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        sleep = 2000
        for k in pairs(Config.odunislemebolge) do
            local ped = PlayerPedId()
            local kordinat = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(kordinat, Config.odunislemebolge[k].x, Config.odunislemebolge[k].y, Config.odunislemebolge[k].z, false)
            if distance < 4 then
                sleep = 2
                DrawMarker(2, Config.odunislemebolge[k].x, Config.odunislemebolge[k].y, Config.odunislemebolge[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 0, 150, 150, 100, 0, 0, 0, 0)
                if distance < 1.40 then
                    DrawText3Ds(Config.odunislemebolge[k].x, Config.odunislemebolge[k].y, Config.odunislemebolge[k].z + 0.5, '[E] Odun Parçala')
                    if IsControlJustReleased(0, 38) then
                        odunisleme()
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        sleep = 2000
        for k in pairs(Config.satisbolge) do
            local ped = PlayerPedId()
            local kordinat = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(kordinat, Config.satisbolge[k].x, Config.satisbolge[k].y, Config.satisbolge[k].z, false)
            if distance < 4 then
                sleep = 2
                DrawMarker(2, Config.satisbolge[k].x, Config.satisbolge[k].y, Config.satisbolge[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 0, 150, 150, 100, 0, 0, 0, 0)
                if distance < 1.40 then
                    DrawText3Ds(Config.satisbolge[k].x, Config.satisbolge[k].y, Config.satisbolge[k].z + 0.4, '[E] Odunları Teslim Et')
                    if IsControlJustReleased(0, 38) then
                        odunteslim()
                    end
                end                             
            end
        end
        Citizen.Wait(sleep)
    end
end)

function odunKes()
    TriggerEvent("mythic_progbar:client:progress", {
        name = "odunkesme",
        duration = 15000, --- Süre ayarlayabilirsin
        label = 'kütük parçalanıyor',
        useWhileDead = false,
        canCancel = true,  --- del basılarak iptal etme
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "amb@world_human_hammering@male@base",
            anim = "base",
            flags = 49,
        },
        prop = {
            model = "prop_tool_fireaxe",
            bone = 57005,
            coords = { x = 0.08, y = -0.4, z = -0.10 },
            rotation = { x = 80.0, y = -20.0, z = 175.0 },
        },
    }, function(status)
        if not status then
			TriggerServerEvent('mrs-woodjob:odunver')  --- vermesi gereken odun config.lua'da
            ClearPedTasksImmediately(ped)
        end
    end)
end

function odunisleme()
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FIRE", 0, true)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "odunisleme",
        duration = 30000, --- Süre ayarlayabilirsin
        label = 'odun parçalanıyor',
        useWhileDead = false,
        canCancel = true, --- del basılarak iptal etme
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
			TriggerServerEvent('mrs-woodjob:isleme')
			ClearPedTasksImmediately(ped)
        end
    end)
end

function odunteslim()
    TriggerEvent("mythic_progbar:client:progress", {
        name = "odunsatis",
        duration = 15000, --- Süre ayarlayabilirsin
        label = 'odunlar teslim ediliyor',
        useWhileDead = false,
        canCancel = true, --- del basılarak iptal etme
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
			TriggerServerEvent('mrs-woodjob:paraver')
			ClearPedTasksImmediately(ped)
        end
    end)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
end
