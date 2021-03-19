fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/*.js',
  'html/*.css',
  'assets/*.png'
}

client_script 'client.lua'

server_script 'server.lua'

dependencies {
  'yarn',
  'webpack'
}

webpack_config 'webpack.config.js'
