local QBCore = exports['qb-core']:GetCoreObject()

function ResetSec()
    if DoesEntityExist(planeguide) then
        DeletePed(planeguide)
        DeletePed(returnplaneguide)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
			if Config.TravelCutscene == false then
				CayoPlaneGuy()
				ReturnCayoPlaneGuy()
			end
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
	if Config.TravelCutscene == false then
    CayoPlaneGuy()
    ReturnCayoPlaneGuy()
	end
end)

AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
		if Config.TravelCutscene == false then
        ResetSec()
		end
	end 
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	if Config.TravelCutscene == false then
    ResetSec()
	end
end)

CreateThread(function()
	if Config.ShowCayoBlips then
		local planeblip = AddBlipForCoord(-1045.59, -2751.33, 20.36)
		SetBlipSprite(planeblip, 16)
		SetBlipColour(planeblip, 5)
		SetBlipScale(planeblip, 0.8)
		SetBlipAsShortRange(planeblip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Lang:t('blip.fly'))
		EndTextCommandSetBlipName(planeblip)
	end
end)

function CayoPlaneGuy()
	if not DoesEntityExist(planeguide) then

        RequestModel("mp_m_securoguard_01")
        while not HasModelLoaded("mp_m_securoguard_01") do
            Wait(0)
        end

        planeguide = CreatePed(4, "mp_m_securoguard_01" , -1045.59, -2751.33, 20.36, 328.42, false, false)

        SetEntityAsMissionEntity(planeguide)
        SetBlockingOfNonTemporaryEvents(planeguide, true)
        SetEntityInvincible(planeguide, true)
        FreezeEntityPosition(planeguide, true)
        TaskStartScenarioInPlace(planeguide, "WORLD_HUMAN_STAND_MOBILE", 0, true)

        exports['qb-target']:AddTargetEntity(planeguide, {
            options = {
                {
                    type = "server",
                    event = "jz-cayotravel:server:takeplane",
                    icon = "fa-solid fa-plane-departure",
                    label = Lang:t('target.fly_perico'),
                },
            },
            distance = 2.5,
        })
	end
end

RegisterNetEvent('jz-cayotravel:client:takeplane', function()
	local Ped = PlayerPedId()

	planemodel = GetHashKey("velum")
	planeped = GetHashKey("s_m_y_pilot_01")
	
	RequestModel(planemodel)
	while not HasModelLoaded(planemodel) do
	Wait(0)
	end
	
	RequestModel(planeped)
	while not HasModelLoaded(planeped) do
	Wait(0)
	end

	if HasModelLoaded(planemodel) and HasModelLoaded(planeped) then
		if Config.Payment then
			QBCore.Functions.TriggerCallback("jz-cayotravel:server:payTrip", function(paid)
				if paid then
	TriggerServerEvent('jz-cayotravel:server:webhook', 1)
    TriggerServerEvent('jz-cayotravel:planecooldown')
	local velumPlane = CreateVehicle(planemodel, -1562.18, -2818.81, 13.0, true, false)
	exports[Config.Fuel]:SetFuel(velumPlane, 100)
    SetEntityHeading(velumPlane, 240.76)
	SetEntityAsMissionEntity(velumPlane, true, true)
	SetModelAsNoLongerNeeded(velumPlane)
	local Pilot = CreatePedInsideVehicle(velumPlane, 6, planeped, -1, true, false)
	SetBlockingOfNonTemporaryEvents(Pilot, true)
	SetPedCanBeDraggedOut(Pilot, false)
	SetDriverAbility(Pilot, 1.0)
	SetDriverAggressiveness(Pilot, 0.0)
	DoScreenFadeOut(3000)
	Wait(4000)
	SetPedIntoVehicle(Ped, velumPlane, 1)
	Wait(2000)
	DoScreenFadeIn(3000)
	TaskVehicleDriveToCoord(Pilot, velumPlane, -907.64, -3196.72, 13.95, 30.0, 0, 1341619767, 786603, 1, true)
	Wait(13000)
	DoScreenFadeOut(3000)
	Wait(10000)
	SetEntityCoords(Ped, 4453.65, -4482.5, 3.22)
	FreezeEntityPosition(Ped, true)
	Wait(2000)
	FreezeEntityPosition(Ped, false)
	SetEntityCoords(velumPlane, 4452.29, -4506.29, 4.19)
	SetEntityHeading(velumPlane, 108.5)
	DoScreenFadeIn(2000)
	Wait(1500)
	TaskVehicleDriveToCoord(Pilot, velumPlane, 3475.4, -4868.43, 143.47, 20.0, 0, 1341619767, 786603, 1, true)
	Wait(10000)
	DeletePed(Pilot)
	QBCore.Functions.DeleteVehicle(velumPlane)
	end
end)
else	
    TriggerServerEvent('jz-cayotravel:server:webhook', 1)
	TriggerServerEvent('jz-cayotravel:planecooldown')
	local velumPlane = CreateVehicle(planemodel, -1562.18, -2818.81, 13.0, true, false)
	exports[Config.Fuel]:SetFuel(velumPlane, 100)
	SetEntityHeading(velumPlane, 240.76)
	SetEntityAsMissionEntity(velumPlane, true, true)
	SetModelAsNoLongerNeeded(velumPlane)
	local Pilot = CreatePedInsideVehicle(velumPlane, 6, planeped, -1, true, false)
	SetBlockingOfNonTemporaryEvents(Pilot, true)
	SetPedCanBeDraggedOut(Pilot, false)
	SetDriverAbility(Pilot, 1.0)
	SetDriverAggressiveness(Pilot, 0.0)
	DoScreenFadeOut(3000)
	Wait(4000)
	SetPedIntoVehicle(Ped, velumPlane, 1)
	Wait(2000)
	DoScreenFadeIn(3000)
	TaskVehicleDriveToCoord(Pilot, velumPlane, -907.64, -3196.72, 13.95, 30.0, 0, 1341619767, 786603, 1, true)
	Wait(13000)
	DoScreenFadeOut(3000)
	Wait(10000)
	SetEntityCoords(Ped, 4453.65, -4482.5, 3.22)
	FreezeEntityPosition(Ped, true)
	Wait(2000)
	FreezeEntityPosition(Ped, false)
	SetEntityCoords(velumPlane, 4452.29, -4506.29, 4.19)
	SetEntityHeading(velumPlane, 108.5)
	DoScreenFadeIn(2000)
	Wait(1500)
	TaskVehicleDriveToCoord(Pilot, velumPlane, 3475.4, -4868.43, 143.47, 20.0, 0, 1341619767, 786603, 1, true)
	Wait(10000)
	DeletePed(Pilot)
	QBCore.Functions.DeleteVehicle(velumPlane)
end
end
end)

CreateThread(function()
	if Config.ShowCayoBlips then
		local returnplaneblip = AddBlipForCoord(4436.58, -4482.53, 3.32)
		SetBlipSprite(returnplaneblip, 16)
		SetBlipColour(returnplaneblip, 5)
		SetBlipScale(returnplaneblip, 0.8)
		SetBlipAsShortRange(returnplaneblip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Lang:t('blip.fly'))
		EndTextCommandSetBlipName(returnplaneblip)
	end
end)

function ReturnCayoPlaneGuy()
	if not DoesEntityExist(returnplaneguide) then

        RequestModel("mp_m_securoguard_01")
        while not HasModelLoaded("mp_m_securoguard_01") do
            Wait(0)
        end

        returnplaneguide = CreatePed(4, "mp_m_securoguard_01" , 4436.58, -4482.53, 3.32, 210.16, false, false)

        SetEntityAsMissionEntity(returnplaneguide)
        SetBlockingOfNonTemporaryEvents(returnplaneguide, true)
        SetEntityInvincible(returnplaneguide, true)
        FreezeEntityPosition(returnplaneguide, true)
        TaskStartScenarioInPlace(returnplaneguide, "WORLD_HUMAN_STAND_MOBILE", 0, true)

        exports['qb-target']:AddTargetEntity(returnplaneguide, {
            options = {
                {
                    type = "server",
                    event = "jz-cayotravel:server:plane_return",
                    icon = "fa-solid fa-plane-departure",
                    label = Lang:t('target.fly_ls'),
                },
            },
            distance = 2.5,
        })
	end
end

RegisterNetEvent('jz-cayotravel:client:plane_return', function()
	local Ped = PlayerPedId()

	local returnplanemodel = GetHashKey("velum")
	local returnplaneped = GetHashKey("s_m_y_pilot_01")
	
	RequestModel(returnplanemodel)
	while not HasModelLoaded(returnplanemodel) do
		Wait(0)
	end
	
	RequestModel(returnplaneped)
	while not HasModelLoaded(returnplaneped) do
		Wait(0)
	end
	
	if HasModelLoaded(returnplanemodel) and HasModelLoaded(returnplaneped) then
		if Config.Payment then
			QBCore.Functions.TriggerCallback("jz-cayotravel:server:payTrip", function(paid)
				if paid then
					TriggerServerEvent('jz-cayotravel:server:webhook', 2)
					TriggerServerEvent('jz-cayotravel:planecooldown')
					local returnvelumPlane = CreateVehicle(returnplanemodel, 4452.09, -4506.35, 4.19, 111.15, true, false)
					exports[Config.Fuel]:SetFuel(returnvelumPlane, 100)
					SetEntityAsMissionEntity(returnvelumPlane, true, true)
					SetModelAsNoLongerNeeded(returnvelumPlane)
					local returnPilot = CreatePedInsideVehicle(returnvelumPlane, 6, returnplaneped, -1, true, false)
					SetBlockingOfNonTemporaryEvents(returnPilot, true)
					SetPedCanBeDraggedOut(returnPilot, false)
					SetDriverAbility(returnPilot, 1.0)
					SetDriverAggressiveness(returnPilot, 0.0)
					DoScreenFadeOut(3000)
					Wait(4000)
					SetPedIntoVehicle(Ped, returnvelumPlane, 1)
					Wait(2000)
					DoScreenFadeIn(3000)
					TaskVehicleDriveToCoord(returnPilot, returnvelumPlane, 3475.4, -4868.43, 143.47, 20.0, 0, 1341619767, 786603, 1, true)
					Wait(10000)
					DoScreenFadeOut(3000)
					Wait(10000)
					SetEntityCoords(Ped, -1041.87, -2745.71, 21.36)
					SetEntityHeading(Ped, 329.66)
					Wait(2000)
					DeletePed(returnPilot)
					QBCore.Functions.DeleteVehicle(returnvelumPlane)
					DoScreenFadeIn(2000)
				end
			end)
		else
			TriggerServerEvent('jz-cayotravel:server:webhook', 2)
			TriggerServerEvent('jz-cayotravel:planecooldown')
			local returnvelumPlane = CreateVehicle(returnplanemodel, 4452.09, -4506.35, 4.19, 111.15, true, false)
			exports[Config.Fuel]:SetFuel(returnvelumPlane, 100)
			SetEntityAsMissionEntity(returnvelumPlane, true, true)
			SetModelAsNoLongerNeeded(returnvelumPlane)
			local returnPilot = CreatePedInsideVehicle(returnvelumPlane, 6, returnplaneped, -1, true, false)
			SetBlockingOfNonTemporaryEvents(returnPilot, true)
			SetPedCanBeDraggedOut(returnPilot, false)
			SetDriverAbility(returnPilot, 1.0)
			SetDriverAggressiveness(returnPilot, 0.0)
			DoScreenFadeOut(3000)
			Wait(4000)
			SetPedIntoVehicle(Ped, returnvelumPlane, 1)
			Wait(2000)
			DoScreenFadeIn(3000)
			TaskVehicleDriveToCoord(returnPilot, returnvelumPlane, 3475.4, -4868.43, 143.47, 20.0, 0, 1341619767, 786603, 1, true)
			Wait(10000)
			DoScreenFadeOut(3000)
			Wait(10000)
			SetEntityCoords(Ped, -1041.87, -2745.71, 21.36)
			SetEntityHeading(Ped, 329.66)
			Wait(2000)
			DeletePed(returnPilot)
			QBCore.Functions.DeleteVehicle(returnvelumPlane)
			DoScreenFadeIn(2000)
		end	
	end
end)