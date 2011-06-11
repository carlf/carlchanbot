require 'cinch'

class Toilet
  include Cinch::Plugin

  match(/toilet (.+)/)

  def execute(m, input)
    output = IO.popen(['toilet', '-w', '80', input])
    output.each do |line|
      m.reply line
    end
  end

end
