name 'jz-cayotravel'
author 'jz-works'
description 'A Cayo Perico QOL Script'
fx_version 'cerulean'
game 'gta5'

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