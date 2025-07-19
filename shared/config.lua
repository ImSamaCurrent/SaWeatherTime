Config = {}

Config.Lang = "FR" -- "FR" or "EN"

Config.Weather = {

	WeatherList = { -- weather cycle (total chance == 100)
	    { weather = "EXTRASUNNY", timer = 15, chance = 25 },
	    { weather = "CLEAR",      timer = 10, chance = 20 },
	    { weather = "CLOUDS",     timer = 10, chance = 15 },
	    { weather = "SMOG",       timer = 5, chance = 5 },
	    { weather = "FOGGY",      timer = 5, chance = 5 },
	    { weather = "OVERCAST",   timer = 5, chance = 8 },
	    { weather = "RAIN",       timer = 5, chance = 7 },
	    { weather = "THUNDER",    timer = 5, chance = 3 },
	    { weather = "CLEARING",   timer = 10, chance = 7 },
	    { weather = "NEUTRAL",    timer = 10, chance = 5 },
	},

	ValidWeather = { -- valide weather for command
        CLEAR = true, EXTRASUNNY = true, CLOUDS = true,
        OVERCAST = true, RAIN = true, THUNDER = true,
        SMOG = true, FOGGY = true, XMAS = true,
        SNOWLIGHT = true, BLIZZARD = true, NEUTRAL = true, 
        CLEARING = true, HALLOWEEN = true
    },

 	DefaultWeatherSelected = 2, -- 2 = { weather = "CLEAR", timer = 10, chance = 20 } in WeatherList
 	DefaultTimerWeather = 10, -- time in minute for unconfig weather duration (used on command)

}

Config.Night = {

	startNight = 22,
	endNight = 07,

}

Config.Command = {

	SetTime = "settime",
	SetWeather = "setweather",
	FreezeTime = "freezetime",
	FreezeWeather = "freezeweather",
	Blackout = "blackout",

}

Config.Language = {

	["FR"] = {

		helpTime = "Utilisation: /"..Config.Command.SetTime.." [heure] [minute]",
		helpWeather = "Type météo invalide.",
		weatherNotConfig = "Météo non configuré",
		newWeather = "Nouvelle météo :",
		newTime = "Accélération vers",
	},

	["EN"] = {

		helpTime = "Use: /"..Config.Command.SetTime.." [hour] [minute]",
		helpWeather = "Invalid weather type.",
		weatherNotConfig = "Weather not configured",
		newWeather = "New weather:",
		newTime = "Acceleration towards",
	}

}


Config.PrintLog = false