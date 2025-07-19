fx_version "adamant"
games {"gta5"}
lua54 'yes'

name "SaWeatherTime"
description "Weather & Time Systeme"
author "ImSama"
discord "https://discord.gg/FAZBexrgtx"

shared_scripts {
	'@ox_lib/init.lua',
	'shared/config.lua'
} 

server_script "server/*.lua"

client_script "client/*.lua"