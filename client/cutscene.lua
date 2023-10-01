local QBCore = exports['qb-core']:GetCoreObject()
local cutscenename =""
function ResetSec2()
    if DoesEntityExist(planeguide) then
        DeletePed(planeguide)
        DeletePed(returnplaneguide)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
			if Config.TravelCutscene then
				cutscene1()
				cutscene2()
			end
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    if Config.TravelCutscene then
    cutscene1()
    cutscene2()
    end
end)

AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
        if Config.TravelCutscene then
        ResetSec2()
        end
	end 
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    if Config.TravelCutscene then
    ResetSec2()
    end
end)

function cutscene1()
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
                    event = "jz-cayotravel:server:takeplanecut",
                    icon = "fa-solid fa-plane-departure",
                    label = "Fly to Perico",
                },
            },
            distance = 2.5,
        })
	end
end

function cutscene2()
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
                    event = "jz-cayotravel:server:takeplanecut2",
                    icon = "fa-solid fa-plane-departure",
                    label = Lang:t('target.fly_ls'),
                },
            },
            distance = 2.5,
        })
	end
end

local pedModel = "s_m_m_pilot_01"
local pedCoords = vector3(0, 0, 0)
local ped

function CreatePedCut()
    RequestModel(pedModel)
    while not HasModelLoaded(GetHashKey(pedModel)) do
        Wait(0)
    end

    ped = CreatePed(4, GetHashKey(pedModel), pedCoords.x, pedCoords.y, pedCoords.z, 0.0, true, true)

    return ped
end

function PlayCut(time, time2, cutsceneName1, cutsceneName2)
    RequestCutscene(cutsceneName1, 8)
    while not HasCutsceneLoaded() do
        Wait(0)
    end
    RequestModel(GetHashKey(pedModel))
    DoScreenFadeIn(1000) 
    SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
    RegisterEntityForCutscene(ped, "MP_1", 0, 0, 64)
    StartCutscene(0)
    Wait(time - 2000)
    DoScreenFadeOut(2000)
    Wait(2000)
    StopCutsceneImmediately()
    Wait(100)
    RequestCutscene(cutsceneName2, 8)
    while not HasCutsceneLoaded() do
        Wait(0)
    end
    RequestModel(GetHashKey(pedModel))
    SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
    RegisterEntityForCutscene(ped, "MP_1", 0, 0, 64)
    StartCutscene(0)
    DoScreenFadeIn(1000)
    Wait(time2 - 2000)
    DoScreenFadeOut(2000)
    Wait(2000)
    StopCutsceneImmediately()
end

RegisterNetEvent("jz-cayotravel:client:cutscenegocayo", function()
    if Config.Payment then
        QBCore.Functions.TriggerCallback("jz-cayotravel:server:payTrip", function(paid)
            if paid then
                TriggerServerEvent('jz-cayotravel:planecooldown')
                TriggerServerEvent('jz-cayotravel:server:webhook', 1)
                ped = CreatePedCut()
                DoScreenFadeOut(1000)
                Wait(1000)
                PlayCut(12200, 12000, "hs4_lsa_take_vel", "hs4_vel_lsa_isd")
                SetEntityCoords(GetPlayerPed(-1), 4438.55, -4482.54, 4.1)
                SetEntityHeading(GetPlayerPed(-1), 226.35)
                DeleteEntity(ped)
                Wait(1000)
                DoScreenFadeIn(1000)
            end
        end)
    else 
        TriggerServerEvent('jz-cayotravel:planecooldown')
        TriggerServerEvent('jz-cayotravel:server:webhook', 1)
        ped = CreatePedCut()
        DoScreenFadeOut(1000)
        Wait(1000)
        PlayCut(12200, 12000, "hs4_lsa_take_vel", "hs4_vel_lsa_isd")
        SetEntityCoords(GetPlayerPed(-1), 4438.55, -4482.54, 4.1)
        SetEntityHeading(GetPlayerPed(-1), 226.35)
        DeleteEntity(ped)
        Wait(1000)
        DoScreenFadeIn(1000)
    end
end)

RegisterNetEvent("jz-cayotravel:client:cutscenegols", function()
    if Config.Payment then
        QBCore.Functions.TriggerCallback("jz-cayotravel:server:payTrip", function(paid)
            if paid then
                TriggerServerEvent('jz-cayotravel:planecooldown')
                TriggerServerEvent('jz-cayotravel:server:webhook', 1)
                ped = CreatePedCut()
                DoScreenFadeOut(1000)
                Wait(1000)
                PlayCut(12200, 11000, "hs4_isd_take_vel", "hs4_lsa_land_vel")
                SetEntityCoords(GetPlayerPed(-1), -1043.05, -2746.68, 21.36)
                SetEntityHeading(GetPlayerPed(-1), 330.43)
                DeleteEntity(ped)
                Wait(1000)
                DoScreenFadeIn(1000)
            end
        end)
    else
        TriggerServerEvent('jz-cayotravel:planecooldown')
        TriggerServerEvent('jz-cayotravel:server:webhook', 2)
        ped = CreatePedCut()
        DoScreenFadeOut(1000)
        Wait(1000)
        PlayCut(12200, 11000, "hs4_isd_take_vel", "hs4_lsa_land_vel")
        SetEntityCoords(GetPlayerPed(-1), -1043.05, -2746.68, 21.36)
        SetEntityHeading(GetPlayerPed(-1), 330.43)
        DeleteEntity(ped)
        Wait(1000)
        DoScreenFadeIn(1000)
    end
end)