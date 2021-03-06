require 'nokogiri'
require 'open-uri'

class PlayAnalyzer

  def initialize(source_type)
    @source_type = source_type
    @source      = source_type.source
    
  end

  def source_type
    @source_type
  end 

  def source
    @source
  end
  
  def words_by_characters name
    all_speeches = @source.xpath("//SPEECH").to_a
    speeches_by_name = all_speeches.select{|s| s.css("SPEAKER/text()").to_s == name }.map{ |s| [s.css("LINE").text.downcase.gsub(/[^0-9a-z ]/i, '').strip.split(" ")] }

    speeche_by_words = []
    
    speeches_by_name.each { |item| item.each { |i| i.each{ |j| speeche_by_words.push(j) } } }
    
    speakers_words = Hash.new(0)
    speeche_by_words.map {|speaker| speakers_words[speaker] += 1}
    speakers_words.each{ |key, value| [ key, value ] }
    
  end

  def characters
    all_speeches = @source.xpath("//SPEECH").to_a
    characters = all_speeches.map{ |s|  [s.css("SPEAKER/text()").to_s][0] }.uniq
  end

  def characters_spoken_lines

    all_speeches = @source.xpath("//SPEECH").to_a
    a = all_speeches.map{ |s|  [s.css("SPEAKER/text()").to_s, s.css("LINE").count] }

    speakers_hash = Hash.new(0)
    a.map {|speaker| speakers_hash[speaker[0]] += speaker[1]}
    speakers_hash.each{ |key, value| [ key, value ] }
    
  end

end
