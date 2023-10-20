local QBCore = exports['qb-core']:GetCoreObject()
local SpawnVehicle = false

RegisterNetEvent('jz-cayotravel:client:openMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Rent a Car",
            isMenuHeader = true,
        },
        {
            id = 1,
            header = "Manchez",
            txt = "500.00 €",
            params = {
                event = "jz-cayotravel:client:spawncar",
                args = {
                    model = 'manchez3',
                    money = 500,
                }
            }
        },
        {
            id = 2,
            header = "Verus",
            txt = "500.00 €",
            params = {
                event = "jz-cayotravel:client:spawncar",
                args = {
                    model = 'verus',
                    money = 500,
                }
            }
        },
		{
            id = 3,
            header = "Winky",
            txt = "750.00 €",
            params = {
                event = "jz-cayotravel:client:spawncar",
                args = {
                    model = 'winky',
                    money = 750,
                }
            }
        },
		{
            id = 4,
            header = "Squaddie",
            txt = "1000.00 €",
            params = {
                event = "jz-cayotravel:client:spawncar",
                args = {
                    model = 'squaddie',
                    money = 1000,
                }
            }
        },
		{
            id = 5,
            header = "Return Vehicle ",
            txt = "Return your rented vehicle.",
            params = {
                event = "jz-cayotravel:client:return",
            }
        },
    })
end)
function ResetSec()
    if DoesEntityExist(cayorental) then
        DeletePed(cayorental)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
				CayoRental()
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    CayoRental()
end)

AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
        ResetSec()
	end 
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    ResetSec()
end)

function CayoRental()
	if not DoesEntityExist(cayorental) then

        RequestModel("ig_mp_agent14")
        while not HasModelLoaded("ig_mp_agent14") do
            Wait(0)
        end

        cayorental = CreatePed(4, "ig_mp_agent14" , 4451.96, -4476.94, 3.31, 203.39, false, false)

        SetEntityAsMissionEntity(cayorental)
        SetBlockingOfNonTemporaryEvents(cayorental, true)
        SetEntityInvincible(cayorental, true)
        FreezeEntityPosition(cayorental, true)
        TaskStartScenarioInPlace(cayorental, "WORLD_HUMAN_STAND_MOBILE", 0, true)

        exports['qb-target']:AddTargetEntity(cayorental, {
            options = {
                {
                    type = "client",
                    event = "jz-cayotravel:client:openMenu",
                    icon = "fa-solid fa-car",
                    label = Lang:t('target.rental'),
                },
            },
            distance = 2.5,
        })
	end
end

RegisterNetEvent('jz-cayotravel:client:spawncar', function(data)
    local money = data.money
    local model = data.model
    local player = PlayerPedId()
    local isVehicleNearby = false
    local nearbyVehicles = QBCore.Functions.GetVehicles()

    local spawnCoords = vector3(4443.99, -4471.88, 4.33)
    local maxDistance = 10.0

    for _, vehicle in pairs(nearbyVehicles) do
        local vehiclePos = GetEntityCoords(vehicle)
        local distance = #(vector3(vehiclePos.x, vehiclePos.y, vehiclePos.z) - spawnCoords)

        if distance < maxDistance then
            isVehicleNearby = true
            break
        end
    end

    if not isVehicleNearby then
        QBCore.Functions.TriggerCallback("jz-cayotravel:server:payrent", function(paid)
            if paid then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, 199.0)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                end, vector4(4442.36, -4467.26, 4.33, 199.0), true)
                Wait(1000)
                local vehicle = GetVehiclePedIsIn(player, false)
                local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                vehicleLabel = GetLabelText(vehicleLabel)
                local plate = GetVehicleNumberPlateText(vehicle)
            end
        end, money)
    else
        QBCore.Functions.Notify("There is a vehicle already there", "error")
    end
end)


RegisterNetEvent('jz-cayotravel:client:return', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify('Returned vehicle!', 'success')
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Wait(2000)
        QBCore.Functions.DeleteVehicle(car)
    else 
        QBCore.Functions.Notify("No vehicle to return", "error")
    end
    SpawnVehicle = false
end)