resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Supermarket'

version '1.0.1'

files {
	'html/ui.html',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js',
	'html/iransans.otf',
	
	'html/img/bread.png',
	'html/img/fixkit.png',
	'html/img/soda.png',
	'html/img/banana.png',
	'html/img/bandage.png',
	'html/img/medikit.png',
	'html/img/orange.png',
	'html/img/donut.png',
	'html/img/fixkit.png',
	'html/img/redbull.png',
	'html/img/jusfruit.png',
	'html/img/close.png',
	'html/img/croquettes.png',
	'html/img/water.png',
	'html/img/plus.png',
	'html/img/minus.png',
	'html/img/chocolate.png',
	'html/img/sandwich.png',
	'html/img/hamburger.png',
	'html/img/cupcake.png',
	'html/img/chips.png',
	'html/img/cocacola.png',
	'html/img/icetea.png',
	'html/img/milk.png',
	'html/img/cigarett.png',
	'html/img/coffe.png',
	'html/img/lighter.png',
	'html/img/redbull.png',
	'html/img/lighter.png',
	'html/img/nurek.png',
	'html/img/tacos.png',
	'html/img/shawarma.png',
	'html/img/sandwichton.png',
	'html/img/abtal.png',
	'html/img/gps.png',
	'html/img/fanta.png',
	'html/img/phone.png',
	'html/img/radio.png',
	'html/img/notepad.png',
	'html/img/whisky.png',
	'html/img/tequila.png',
	'html/img/vodka.png',
	'html/img/beer.png',
	'html/img/wine.png',
	'html/img/champagne.png',
	'html/img/ocb.png'
}

ui_page 'html/ui.html'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua'
}

dependency 'es_extended'
