local data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent('redmscrp_farmer_market:sellcorn')
AddEventHandler('redmscrp_farmer_market:sellcorn', function()
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local ItemData = data.getItem(source, 'corn')
		print(ItemData.ItemAmount)
		local totalproduct = (ItemData.ItemAmount)
		if totalproduct >= 1 then
			local totalmoney = (totalproduct * 2)
			local totalxp = (totalproduct * 2)
			user.addMoney(totalmoney)
			user.addXP(totalxp)
            ItemData.RemoveItem(totalproduct)
            TriggerClientEvent("redemrp_notification:start", _source, "You sold " ..totalproduct.. " corn, for " ..totalmoney.."$ | "..totalxp.."XP", 5)
		else
            TriggerClientEvent("redemrp_notification:start", _source, 'You dont have any corn to sell', 5)
        end
    end)
end)

RegisterServerEvent('redmscrp_farmer_market:sellcarrot')
AddEventHandler('redmscrp_farmer_market:sellcarrot', function()
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local ItemData = data.getItem(source, 'carrot')
		print(ItemData.ItemAmount)
		local totalproduct = (ItemData.ItemAmount)
		if totalproduct >= 1 then
			local totalmoney = (totalproduct * 5)
			local totalxp = (totalproduct * 5)
			user.addMoney(totalmoney)
			user.addXP(totalxp)
            ItemData.RemoveItem(totalproduct)
            TriggerClientEvent("redemrp_notification:start", _source, "You sold " ..totalproduct.. " carrot, for " ..totalmoney.."$ | "..totalxp.."XP", 5)
		else
            TriggerClientEvent("redemrp_notification:start", _source, 'You dont have any carrots to sell', 5)
        end
    end)
end)

RegisterServerEvent('redmscrp_farmer_market:sellbread')
AddEventHandler('redmscrp_farmer_market:sellbread', function()
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local ItemData = data.getItem(source, 'bread')
		print(ItemData.ItemAmount)
		local totalproduct = (ItemData.ItemAmount)
		if totalproduct >= 1 then
			local totalmoney = (totalproduct * 10)
			local totalxp = (totalproduct * 10)
			user.addMoney(totalmoney)
			user.addXP(totalxp)
            ItemData.RemoveItem(totalproduct)
            TriggerClientEvent("redemrp_notification:start", _source, "You sold " ..totalproduct.. " bread, for " ..totalmoney.."$ | "..totalxp.."XP", 5)
		else
            TriggerClientEvent("redemrp_notification:start", _source, 'You dont have any bread to sell', 5)
        end
    end)
end)