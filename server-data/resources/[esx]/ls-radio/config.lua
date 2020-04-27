Config = {}

Config.RestrictedChannels = 10 -- channels that are encrypted (EMS, Fire and police can be included there) if we give eg 10, channels from 1 - 10 will be encrypted
Config.enableCmd = true --  /radio command should be active or not (if not you have to carry the item "radio") true / false

Config.messages = {

  ['not_on_radio'] = 'Vous n\'êtes actuellement sur aucune radio',
  ['on_radio'] = 'Vous êtes actuellement à la radio: <b>',
  ['joined_to_radio'] = 'Vous avez rejoint la radio: <b>',
  ['restricted_channel_error'] = 'Vous ne pouvez pas rejoindre les chaînes cryptées!',
  ['you_on_radio'] = 'Vous êtes déjà à la radio: <b>',
  ['you_leave'] = 'Vous avez quitté la radio: <b>'

}
