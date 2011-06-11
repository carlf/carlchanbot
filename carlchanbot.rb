$LOAD_PATH.unshift('./plugins')

require 'cinch'
require 'qdb'
require 'ascii_art'
require 'toilet'
require 'fortune'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.oftc.net'
    c.channels = ["#carlchan"]
    c.nick = 'carlchanbot'
    c.plugins.plugins = [Qdb, AsciiArt, Toilet, Fortune]
  end
end

bot.start
