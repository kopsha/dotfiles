local config_plugins = {}

-- list all plugins that need to be configured
config_plugins.treesitter = require "config-plugins.treesitter"
config_plugins.comment = require "config-plugins.comment"
config_plugins.telescope = require "config-plugins.telescope"
config_plugins.mason = require "config-plugins.mason"
config_plugins.lsp = require "config-plugins.lsp"

return config_plugins
