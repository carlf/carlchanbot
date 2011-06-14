require 'cinch'
require 'lib/html_grabber'

class UrbanDictionary
  include Cinch::Plugin

  match(/ud (.+)$/)

  def execute(m, term)
    grabber = HtmlGrabber.new
    url = "http://www.urbandictionary.com/define.php?term=#{term}"
    result = grabber.get_results(url, 'div.definition')
    if(result.length > 0)
      result.each do |line|
        m.reply line
      end
    else
      m.reply "No definition found"
    end
  end
end
