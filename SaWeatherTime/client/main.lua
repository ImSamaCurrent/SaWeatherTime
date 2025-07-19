local currentHour, currentMinute = 12, 0
local targetHour, targetMinute = nil, nil
local currentWeather = nil
local isAccelerating = false
local sync = true


RegisterNetEvent("timeSync:updateblackout", function(boolean)
    SetBlackout(boolean)
end)

RegisterNetEvent("timeSync:updateWeather", function(newWeather)
    currentWeather = newWeather
    setWeather()
end)

function setWeather(instant)
    local instant = instant and true or false
    if sync then
        if not instant then
            SetWeatherTypeOverTime(currentWeather, 15.0)
            Wait(15000)
        end
        SetWeatherTypeNowPersist(currentWeather)
        Print("currentWeather: ", currentWeather)
        if currentWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end


RegisterNetEvent("timeSync:updateTime")
AddEventHandler("timeSync:updateTime", function(hour, minute)
    if not isAccelerating then
        currentHour = hour
        currentMinute = minute
    end
end)

CreateThread(function()
    while true do
        if not isAccelerating and sync then
            NetworkOverrideClockTime(currentHour, currentMinute, 0)
        end
        Wait(250)
    end
end)


RegisterNetEvent("timeSync:accelerateTo")
AddEventHandler("timeSync:accelerateTo", function(h, m, instant)
    targetHour = h
    targetMinute = m
    if sync then
        StartTimeAcceleration(instant)
    end
end)

function StartTimeAcceleration(instant)
    local instant = (instant == "true") and true or false
    isAccelerating = true

    local totalCurrent = currentHour * 60 + currentMinute
    local totalTarget = targetHour * 60 + targetMinute

    if totalTarget < totalCurrent then
        totalTarget = totalTarget + 1440 
    end

    local diff = totalTarget - totalCurrent
    local accelDuration = 5000 
    local startTime = GetGameTimer()

    CreateThread(function()
        if not instant then
            while isAccelerating do
                local elapsed = GetGameTimer() - startTime
                if elapsed >= accelDuration then break end

                local progress = elapsed / accelDuration
                local minutesPassed = math.floor(diff * progress)

                local newTotal = totalCurrent + minutesPassed
                local newHour = math.floor(newTotal / 60) % 24
                local newMinute = math.floor(newTotal % 60)

                NetworkOverrideClockTime(newHour, newMinute, 0)
                Wait(0) 
            end
        end

        NetworkOverrideClockTime(targetHour, targetMinute, 0)
        currentHour = targetHour
        currentMinute = targetMinute
        isAccelerating = false
    end)
end


function SyncStat(boolean)
    sync = boolean
    if boolean then
        StartTimeAcceleration(true)
        setWeather(true)
    end
end

-- synchro
CreateThread(function()
    Wait(1500)
    if currentWeather == nil then
        TriggerServerEvent("timeSync:requestTime")
    end
end)


exports('IsNight', function()
    return ( currentHour > 22 and currentHour < 07 )
end)

exports('ToggleWeatherTimeSync', function(boolean)
    SyncStat(boolean)
end)
    
RegisterNetEvent("timeSync:SetSyncTW")
AddEventHandler("timeSync:SetSyncTW", function(boolean)
    SyncStat(boolean)
end)
















---------------------------------------------------------


function Print(...)
    if Config.PrintLog then
        print(...)
    end
end