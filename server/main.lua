ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('mrs-woodjob:odunver')
AddEventHandler('mrs-woodjob:odunver', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.addInventoryItem('wood', Config.verilentahta) then
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = Config.verilentahta..'x Odun elde ettin.'})
    end
end)

RegisterServerEvent('mrs-woodjob:isleme')
AddEventHandler('mrs-woodjob:isleme', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local gerekenodun = xPlayer.getQuantity('wood') --- qb to esx envanter kullananlar için 
	--- local gerekenodun = xPlayer.getInventoryItem('wood').count --- esx envnater için

	if gerekenodun >= Config.islemekicingerekenodun then
		xPlayer.removeInventoryItem('wood', Config.islemekicingerekenodun)
		xPlayer.addInventoryItem('cutted_wood', Config.verilentahta)
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = Config.verilentahta..'x Kesilmiş Odun elde ettin.'})
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Odun sayısı '..Config.islemekicingerekenodun..'\'den az olamaz!'})
  	end
end)

RegisterServerEvent('mrs-woodjob:paraver')
AddEventHandler('mrs-woodjob:paraver', function()

    local xPlayer = ESX.GetPlayerFromId(source)
	local money = math.random(30, 45) --- random olarak para veriyor burdan ayarlanabilir.
    
	if xPlayer.removeInventoryItem('cutted_wood', Config.verilentahta) then
        xPlayer.addMoney(money)
    end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2mrs-woodjob^0] - Script başlatıldı!')
	end
end)