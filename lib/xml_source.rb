require 'nokogiri'

class XmlSource
  def initialize(path)
      @path = path
  end

  def source
    xml_doc  = Nokogiri::XML(@path)
  	# open the file and read it as XML
  end

end
