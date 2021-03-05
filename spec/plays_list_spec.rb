require 'spec_helper'
require 'webmock/rspec'
require 'nokogiri'
WebMock.disable_net_connect!(allow_localhost: true)

describe PlaysList do
  before do
    path = path = "spec/fixtures/list.html"
    response = File.new(path).read
    stub_request(:get, /.*www.ibiblio.org.*/).
    with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(status: 200, body: response, headers: {})
  end

  subject { PlaysList.new.get }

  describe '#list' do
    it 'returns play list' do
      expected = [
        ["http://www.ibiblio.org/xml/examples/shakespeare/all_well.xml", "All's Well That Ends Well"],
        ["http://www.ibiblio.org/xml/examples/shakespeare/as_you.xml", "As You Like It"]
      ]
      expect(subject.list).to include(*expected)
    end
  end

end
