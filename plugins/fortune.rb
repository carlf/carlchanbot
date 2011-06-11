require 'cinch'

class Fortune
  include Cinch::Plugin

  match(/fortune$/, method: :fortune_rand)

  def fortune_rand(m)
    output = IO.popen(['fortune', '-a'])
    output.each {|line| m.reply line}
  end
end
