$: << File.dirname(__FILE__)

require 'cinch'
require 'yaml'
require 'plugins/qdb'
require 'plugins/ascii_art'
require 'plugins/toilet'
require 'plugins/fortune'
require 'plugins/urban_dictionary'

yaml = YAML::load(File.open('config.yml'))

bot = Cinch::Bot.new do
  configure do |c|
    c.server = yaml['server']
    c.channels = [yaml['channel']]
    c.nick = yaml['nick']
    c.plugins.plugins = [Qdb, AsciiArt, Toilet, Fortune, UrbanDictionary]
  end
end

bot.start
