MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

local farmersmarket = {

    { x= 1284.32, y = -6871.90, z = 43.45 }, -- Guarma Farmers Market
--    { x= -373.07, y = 722.46, z = 116.43 }, -- Valentine Farmers Market    
	
}

local active = false
local ShopPrompt
local hasAlreadyEnteredMarker, lastZone
local currentZone = nil

function SetupShopPrompt()
    Citizen.CreateThread(function()
        local str = 'Open Farmer Market'
        ShopPrompt = PromptRegisterBegin()
        PromptSetControlAction(ShopPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ShopPrompt, str)
        PromptSetEnabled(ShopPrompt, false)
        PromptSetVisible(ShopPrompt, false)
        PromptSetHoldMode(ShopPrompt, true)
        PromptRegisterEnd(ShopPrompt)

    end)
end

AddEventHandler('redmscrp_farmer_market:hasEnteredMarker', function(zone)
    currentZone     = zone
end)

AddEventHandler('redmscrp_farmer_market:hasExitedMarker', function(zone)
    if active == true then
        PromptSetEnabled(ShopPrompt, false)
        PromptSetVisible(ShopPrompt, false)
        active = false
    end
    WarMenu.CloseMenu()
	currentZone = nil
end)

Citizen.CreateThread(function()
    SetupShopPrompt()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local isInMarker, currentZone = false

        for k,v in ipairs(farmersmarket) do
            if (Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1.5) then
                isInMarker  = true
                currentZone = 'farmersmarket'
                lastZone    = 'farmersmarket'
            end
        end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			TriggerEvent('redmscrp_farmer_market:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('redmscrp_farmer_market:hasExitedMarker', lastZone)
		end

    end
end)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('market', "Farmers Market")
    WarMenu.SetSubTitle('market', 'What goods have you brought')
    WarMenu.CreateSubMenu('sell', 'market', 'What goods have you brought')

    while true do

        if WarMenu.IsMenuOpened('market') then
            if WarMenu.MenuButton('Sell your goods', 'sell') then
            end
            WarMenu.Display()			
        elseif WarMenu.IsMenuOpened('sell') then
            if WarMenu.Button('Sell your farmed corn') then
				TriggerServerEvent("redmscrp_farmer_market:sellcorn", 1)  
            elseif WarMenu.Button('Sell your farmed carrots') then
				TriggerServerEvent("redmscrp_farmer_market:sellcarrot", 1)
			elseif WarMenu.Button('Sell your fresh bread') then
				TriggerServerEvent("redmscrp_farmer_market:sellbread", 1)
            end
            WarMenu.Display()
        
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if currentZone then
            if active == false then
                PromptSetEnabled(ShopPrompt, true)
                PromptSetVisible(ShopPrompt, true)
                active = true
            end
            if PromptHasHoldModeCompleted(ShopPrompt) then
				WarMenu.OpenMenu('market')
                WarMenu.Display()
                PromptSetEnabled(ShopPrompt, false)
                PromptSetVisible(ShopPrompt, false)
                active = false

				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)



RegisterNetEvent('redmscrp_farmer_market:alert')	
AddEventHandler('redmscrp_farmer_market:alert', function(txt)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", txt, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)