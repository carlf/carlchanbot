require 'cinch'
require 'utility'

class Qdb
  include Cinch::Plugin

  match(/qdb #(\d+)$/, method: :grab_qdb)
  match(/qdb ([^#].+)$/, method: :search_qdb)
  match(/qdb$/, method: :grab_random_qdb)

  def grab_qdb(m, id)
    grabber = HtmlGrabber.new
    url = "http://www.bash.org/?#{id}"
    result = grabber.get_results(url, 'p.qt')
    if(result.length > 0)
      result.each do |line|
        m.reply line
      end
    else
      m.reply "Quote not found"
    end
  end

  def search_qdb(m, search_string)
    grab_qdb(m, "search=#{search_string}&sort=0&show=25")
  end

  def grab_random_qdb(m)
    grab_qdb(m, 'random1')
  end
end
