resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.0.0'

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/fr.lua',
  'locales/sv.lua',
  'locales/cs.lua',
  'config.lua',
  'client/main.lua'
}

server_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/fr.lua',
  'locales/sv.lua',
  'locales/cs.lua',
  'config.lua',
  'server/main.lua'
}
