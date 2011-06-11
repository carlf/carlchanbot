require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'htmlentities'

class Qdb
  include Cinch::Plugin

  match(/qdb #(\d+)$/, method: :grab_qdb)
  match(/qdb ([^#].+)$/, method: :search_qdb)
  match(/qdb$/, method: :grab_random_qdb)

  def grab_qdb(m, id)
    coder = HTMLEntities.new
    doc = Nokogiri::HTML(open("http://www.bash.org/?#{id}"))
    quotes = doc.css("p.qt")
    if(quotes.length > 0)
      coder.decode(quotes.first.content).split("\n").each do |line|
        m.reply line
      end
    else
      m.reply "Quote not found"
    end
  end

  def search_qdb(m, search_string)
    search_string.gsub!(/ /, '+')
    grab_qdb(m, "search=#{search_string}&sort=0&show=25")
  end

  def grab_random_qdb(m)
    grab_qdb(m, 'random1')
  end
end
