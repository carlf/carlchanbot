$: << File.dirname(__FILE__)

require 'cinch'
require 'yaml'
require 'plugins/qdb'
require 'plugins/ascii_art'
require 'plugins/toilet'
require 'plugins/fortune'
require 'plugins/urban_dictionary'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.oftc.net'
    c.channels = ["#carlchan"]
    c.nick = 'carlchanbot'
    c.plugins.plugins = [Qdb, AsciiArt, Toilet, Fortune, UrbanDictionary]
  end
end

bot.start
