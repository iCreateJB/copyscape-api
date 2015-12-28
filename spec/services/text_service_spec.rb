require 'spec_helper'

describe TextSearchService do
  let(:options){ OpenStruct.new(data: {}, errors: []) }

  subject{ TextSearchService.new(options) }

  it { expect(subject.class.respond_to?(:create)).to eq(true) }

  context '.create' do
    before do
      data = double("Request", data: {}, success?: true )
      allow(CopyScapeService).to receive(:post).and_return(data)
    end

    it { expect(subject.create.respond_to?(:success?)).to  eq(true) }
  end
end
