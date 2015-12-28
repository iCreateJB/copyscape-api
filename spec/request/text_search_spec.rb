require 'spec_helper'

describe Request::TextSearch do
  let(:options){
    {

    }
  }

  subject{ Request::TextSearch.new(options) }

  it { expect(subject.respond_to?(:valid?)).to eq(true) }

  context 'valid' do
    before do
      options.merge!(data: 'Through the looking glass')
    end

    it 'should not return an error on text' do
      expect(subject.valid?).to eq(true)
    end

    it 'should not return an error on format' do
      options.merge!(format: 'html')
      expect(subject.valid?).to eq(true)
    end
  end

  context 'invalid' do
    it { expect(subject.valid?).to eq(false) }

    it 'should return an error on :text' do
      subject.valid?
      expect(subject.errors.include?(:data)).to eq(true)
    end
  end
end
