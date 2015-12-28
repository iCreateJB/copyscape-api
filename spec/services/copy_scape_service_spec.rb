require 'spec_helper'

describe CopyScapeService do
  let(:method){ :post }
  let(:url){ '/' }
  let(:data){
    {
      t: 'Through the looking glass'
    }
  }

  subject{ CopyScapeService.new(method,url,data) }

  it { expect(subject.respond_to?(:send)).to eq(true) }
  it { expect(subject.class.respond_to?(:get)).to eq(true) }
  it { expect(subject.class.respond_to?(:post)).to eq(true) }

  context 'Request' do
    before do
      api = double('Faraday', status: 200, body: {})
      allow(api).to receive(:post).and_return(api)
      allow(Faraday).to receive(:new).and_return(api)
    end

    it 'should send a request for text to be searched' do
      expect(subject.send).to be_an_instance_of(OpenStruct)
    end
  end
end
