require 'nokogiri'
require 'uri'
require 'open-uri'

class HtmlGrabber
  def get_results(url, selector)
    coder = HTMLEntities.new
    doc = Nokogiri::HTML(open(URI.escape(url)))
    result = doc.css(selector)
    if(result.length > 0)
      return coder.decode(result.first.content).split("\n")
    else
      return []
    end
  end
end
