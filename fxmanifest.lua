fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.0.0'

author 'spoodyCreations, Realityy5m'
description 'Simple, Modern playerlist UI for serious RP frameworks'

ui_page 'nui/dist/index.html'

files {
    'nui/dist/index.html',
    'nui/dist/assets/*.js',
    'nui/dist/assets/*.css',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'game/client.lua'
server_script 'game/server.lua'