require 'cinch'
require 'yaml'
require 'fileutils'

class SeenUser < Struct.new(:nick, :msg, :time)
end

class Seen
  include Cinch::Plugin

  timer(5, method: :save_seen)
  listen_to :channel
  match(/seen (.+)$/)

  def initialize(*args)
    super
    if(File.readable?('data/seen/seen.yml'))
      @seen_entries = YAML::load(File.open('data/seen/seen.yml'))
    else
      @seen_entries = {}
    end
  end

  def save_seen
    if(!File.directory?('data/seen'))
      FileUtils.mkdir_p('data/seen')
    end
    File.open('data/seen/seen.yml', 'w') do |out|
      YAML.dump(@seen_entries, out)
    end
  end

  def listen(m)
    @seen_entries[m.user.nick] = SeenUser.new(m.user.nick, m.message, Time.now)
  end

  def execute(m, nick)
    if(@seen_entries.has_key?(nick))
      seen_time = @seen_entries[nick].time.strftime('%F %T %Z')
      msg = @seen_entries[nick].msg
      m.reply "#{nick} last seen #{seen_time}: #{msg}"
    else
      m.reply "#{nick} not seen"
    end
  end
end
