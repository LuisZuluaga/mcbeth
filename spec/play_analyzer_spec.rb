require 'spec_helper'
require 'nokogiri'
require 'webmock/rspec'


describe PlayAnalyzer do
  before do
    path = "spec/fixtures/macbeth.xml"
    response = File.new(path).read
    stub_request(:get, /.*www.ibiblio.org.*/).
    with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(status: 200, body: response, headers: {})
  end

  subject { PlayAnalyzer.new(HttpSource.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")) }

  describe '#characters' do
    it 'returns Macbeth characters' do
      expect(subject.characters).to include('MACBETH', 'BANQUO', 'DUNCAN')
    end
  end

  describe '#characters in total' do
    it 'returns the number of all of the Macbeth characters' do
      expect(subject.characters.count).to eq(42)
    end
  end

  describe '#characters at least one' do
    it 'at least one character in the play' do
      expect(subject.characters.count).to be > 0
    end
  end

  describe '#characters_spoken_lines' do
    it 'returns lines spoken by characters' do
      expected = [
        ['MACBETH', 719], ['BANQUO', 113], ['DUNCAN', 70]
      ]
      expect(subject.characters_spoken_lines.to_a).to include(*expected)
    end
  end

  describe '#words_by_characters' do
    it 'returns words and its frequency spoken by a given character' do
      results = subject.words_by_characters('MACBETH').to_a
      expect(results).to include(["they", 24],
                                ["thy", 24]
                                )
    end
  end
end
