local config_plugins = {}

-- list all plugins that need to be configured
config_plugins.lsp = require "config-plugins.lsp"
config_plugins.treesitter = require "config-plugins.treesitter"
config_plugins.comment = require "config-plugins.comment"
config_plugins.telescope = require "config-plugins.telescope"

return config_plugins
