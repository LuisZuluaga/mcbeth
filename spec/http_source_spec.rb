require 'spec_helper'
require 'webmock/rspec'
require 'nokogiri'
WebMock.disable_net_connect!(allow_localhost: true)

describe HttpSource do
  before do
    path = "spec/fixtures/macbeth.html"
    response = File.new(path).read
    stub_request(:get, /.*www.ibiblio.org.*/).
    with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(status: 200, body: response, headers: {})
  end

  subject { HttpSource.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml") }

  describe '#source' do
    it 'returns nokogiri object' do
      expect(subject.source).to be_a Nokogiri::XML::Document
    end
  end

end
