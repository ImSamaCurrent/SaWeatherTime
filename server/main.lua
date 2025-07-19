local hour, minute = 12, 0
local baseSpeed = 5000 -- 1 minute IG toutes les 10 secondes
local freezetime, freezeweather = false, false

local WeatherChange = false
local Weather = Config.Weather.WeatherList[Config.Weather.DefaultWeatherSelected].weather
local lastWeather = Weather

local blackout = false


CreateThread(function()
    while true do
        Wait(baseSpeed)
        if not freezetime then
            minute = minute + 1
            if minute >= 60 then
                minute = 0
                hour = hour + 1
                if hour >= 24 then
                    hour = 0
                end
            end
            if #GetPlayers() > 0 then
                TriggerClientEvent("timeSync:updateTime", -1, hour, minute)
            end
        end
    end
end)


local function normalizeChances(weatherList)
    local total = 0
    for _, w in ipairs(weatherList) do
        total = total + w.chance
    end

    local normalized = {}
    for _, w in ipairs(weatherList) do
        local adjusted = math.floor((w.chance / total) * 100)
        table.insert(normalized, { 
            weather = w.weather,  
            timer = w.timer, 
            chance = adjusted 
        })
    end

    local sum = 0
    for _, w in ipairs(normalized) do sum = sum + w.chance end
    if sum < 100 then
        normalized[#normalized].chance = normalized[#normalized].chance + (100 - sum)
    elseif sum > 100 then
        normalized[#normalized].chance = normalized[#normalized].chance - (sum - 100)
    end

    return normalized
end

local function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

function getRandomWeather()
    local normalizedList = normalizeChances(Config.Weather.WeatherList)

    local rand = math.random(1, 100)
    local sum = 0

    local shuffled = { table.unpack(normalizedList) }
    shuffle(shuffled)

    for _, w in ipairs(shuffled) do
        sum = sum + w.chance
        if rand <= sum then
            return w
        end
    end

    return Config.Weather.WeatherList[Config.Weather.DefaultWeatherSelected] 
end




local function getWeatherInfo(weatherName)
    for _, data in pairs(Config.Weather.WeatherList) do
        if data.weather == weatherName then
            return data
        end
    end
    Print(Config.Language[Config.Lang].weatherNotConfig)
    return { weather = weatherName, timer = Config.Weather.DefaultTimerWeather }
end


local currentCycleId = 0

local function startWeatherCycle(weatherData)
    currentCycleId = currentCycleId + 1

    CreateThread(function()
        local cycleId = currentCycleId
        local currentWeather = weatherData

        Print("currentCycleId: ", cycleId)
        Print("currentWeather: ", currentWeather.weather, "Duration: ", currentWeather.timer, "Chance: ", currentWeather.chance)

        if #GetPlayers() > 0 then
            TriggerClientEvent("timeSync:updateWeather", -1, currentWeather.weather)
        end

        local timer = GetGameTimer() + (currentWeather.timer * 60000)

        while GetGameTimer() < timer do
            if currentCycleId ~= cycleId then
                break
            end
            Wait(5000)
        end

        if currentCycleId == cycleId and not freezeweather then
            local newWeather
            repeat
                newWeather = getRandomWeather()
                Weather = newWeather.weather
            until newWeather.weather ~= currentWeather.weather

            startWeatherCycle(newWeather)
        end
    end)
end


CreateThread(function()
    local newWeather = getRandomWeather()
    Weather = newWeather.weather
    startWeatherCycle(newWeather)
end)


RegisterCommand(Config.Command.SetTime, function(source, args)
    local h = tonumber(args[1])
    local m = tonumber(args[2]) or 0
    local instant = args[3]

    if h and m then
        h = h % 24
        m = m % 60
        hour = h
        minute = m
        print((Config.Language[Config.Lang].newTime.." %02d:%02d..."):format(h, m))
        TriggerClientEvent("timeSync:accelerateTo", -1, h, m, instant)
    else
        print(Config.Language[Config.Lang].helpTime)
    end
end, true)

RegisterCommand(Config.Command.SetWeather, function(source, args)
    if WeatherChange then return end
    WeatherChange = true
    local newWeather = string.upper(args[1])

    if not Config.Weather.ValidWeather[newWeather] then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "^1Erreur", Config.Language[Config.Lang].helpWeather }
        })
        return
    end
    Print((Config.Language[Config.Lang].newWeather.." %s "):format(newWeather))
    local data = getWeatherInfo(newWeather)
    startWeatherCycle(data)
    Wait(1000)
    WeatherChange = false
end, false)

RegisterCommand(Config.Command.FreezeWeather, function(source, args)
    if WeatherChange then return end
    freezeweather = not freezeweather
    local newstatus = freezeweather and "FREEZE" or "UNFREEZE"
    print("Weather: "..newstatus)
end, true)

RegisterCommand(Config.Command.FreezeTime, function(source, args)
    freezetime = not freezetime
    local newstatus = freezetime and "FREEZE" or "UNFREEZE"
    print("Time: "..newstatus)
end, true)


RegisterCommand(Config.Command.Blackout, function(source, args)
    blackout = not blackout
        for _, playerId in ipairs(GetPlayers()) do
            TriggerClientEvent("timeSync:updateblackout", playerId, blackout)
        end
    local newstatus = blackout and "ACTIFE" or "INACTIFE"
    print("Blackout: "..newstatus)
end, true)


---------------

RegisterNetEvent("timeSync:requestTime", function()
    TriggerClientEvent("timeSync:updateTime", source, hour, minute)
    TriggerClientEvent("timeSync:updateWeather", source, Weather)
    TriggerClientEvent("timeSync:updateblackout", source, blackout)
end)




exports('IsNight', function()
    return ( hour > Config.Night.startNight and hour < Config.Night.endNight )
end)






































---------------------------------------------------------


function Print(...)
    if Config.PrintLog then
        print(...)
    end
end


