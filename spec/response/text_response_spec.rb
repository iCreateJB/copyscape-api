require 'spec_helper'

describe Response::TextSearch do
  let(:response){ File.open('./spec/fixtures/einstein.xml').read }
  let(:data){ OpenStruct.new(body: response, code: 200, success?: true) }

  subject{ Response::TextSearch.new(data) }

  it { expect(subject.respond_to?(:parse)).to eq(true) }

  context 'parse' do
    it { expect(subject.parse).to be_an_instance_of(OpenStruct) }
    it { expect(subject.parse.code).to eq(data.code) }
    it { expect(subject.parse.count).to eq(66) }
    it { expect(subject.parse.entries).to be_an_instance_of(Array) }

    context 'entries' do
      before do
        @entry = subject.parse.entries.first
      end

      it { expect(@entry.respond_to?(:index)).to eq(true) }
      it { expect(@entry.respond_to?(:url)).to eq(true) }
      it { expect(@entry.respond_to?(:title)).to eq(true) }
      it { expect(@entry.respond_to?(:html_snippet)).to eq(true) }
      it { expect(@entry.respond_to?(:text_snippet)).to eq(true) }
      it { expect(@entry.respond_to?(:view_url)).to eq(true) }
    end
  end

  context 'error' do
    let(:err_resp){ File.open('./spec/fixtures/error.resp.xml').read }
    let(:data){ OpenStruct.new(body: err_resp, code: 200, success?: true) }

    subject { Response::TextSearch.new(data) }

    it { expect(subject.parse.entries).to eq([]) }
    it { expect(subject.parse.count).to eq(0) }
    it { expect(subject.parse.code).to eq(400) }
    it { expect(subject.parse.message).to eq('You did something wrong.')}
  end

end
