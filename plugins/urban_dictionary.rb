require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'htmlentities'
require 'cgi'

class UrbanDictionary
  include Cinch::Plugin

  match(/ud (.+)$/)

  def execute(m, term)
    coder = HTMLEntities.new
    doc = Nokogiri::HTML(open("http://www.urbandictionary.com/define.php?term=#{CGI.escape(term)}"))
    defs = doc.css('div.definition')
    if(defs.length > 0)
      coder.decode(defs.first.content).split("\n").each do |line|
        m.reply line
      end
    else
      m.reply "Definition not found"
    end
  end
end
