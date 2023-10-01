name 'jz-cayotravel'
author 'jamazzz'
description 'A Cayo Perico Heist script for FiveM by jamazzz'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua',
    'locales/en.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/**/*.lua',
}

server_scripts {
    'server/**/*.lua',
}

lua54 'yes'