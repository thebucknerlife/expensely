require 'rails_helper'

RSpec.describe Receipt, type: :model do
  let(:request) { Request.new }
  let(:request_item) { RequestItem.new(request: request) }
  let(:receipt) { Receipt.new(request_item: request_item, cloudinary_json: json) }
  let(:json) { { url: 'http://res.cloudinary.com/dpquc2ssm/image/upload/v1486788807/x7w8cbcnj1eyz1nhnupf.jpeg' } }

  it 'is a thing' do
    expect(receipt).to be_valid?
  end

  it 'has a valid url' do
    expect(receipt.url).to eq('')
  end

  it 'has a valid url' do
    expect(receipt.thumbnail).to eq('')
  end

  context 'when a PDF' do
    let(:json) { { url: 'http://res.cloudinary.com/dpquc2ssm/image/upload/v1486788807/x7w8cbcnj1eyz1nhnupf.pdf' } }
    let(:receipt) { Receipt.new(request_item: request_item, cloudinary_json: json) }

    it 'has a valid url' do
      expect(receipt.url).to eq('')
    end

    it 'has a valid thumbnail' do
      expect(receipt.thumbnail).to eq('')
    end
  end
end
