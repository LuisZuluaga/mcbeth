require 'nokogiri'
require 'open-uri'

class PlaysList
  def initialize
    @url = "http://www.ibiblio.org/xml/examples/shakespeare/"
  end

  #TO-DO Iemplement get method
  def url
    @url
  end

  def get
    @html = Nokogiri::HTML(URI.open(@url))
    self
  end

  def list
    extract_names_and_urls = lambda do |doc|
      [extact_url(@url, doc), extract_titles(doc)]
    end
    
    @html.css('a').map(&extract_names_and_urls)
  end

  def number_of_lists
    @html.css('a').length
  end

  def html
    # @html it is set on get method
    @html
  end

  def extact_url(url, document)
    url + document['href']
  end

  def extract_titles(document)
    document.text
  end

end
