local config_plugins = {}

-- list all plugins that need to be configured
config_plugins.comment = require "config-plugins.comment"
config_plugins.telescope = require "config-plugins.telescope"

return config_plugins
