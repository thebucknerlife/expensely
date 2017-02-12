require 'rails_helper'

RSpec.describe Receipt, type: :model do
  let(:request) { Request.new }
  let(:request_item) { RequestItem.new(request: request) }
  let(:receipt) { Receipt.new(request_item: request_item, cloudinary_json: json) }
  let(:json) { { url: 'http://res.cloudinary.com/dpquc2ssm/image/upload/v1486788807/x7w8cbcnj1eyz1nhnupf.jpeg' } }

  it 'has a valid #url' do
    expect(receipt.url).to eq('http://res.cloudinary.com/dpquc2ssm/image/upload/v1486788807/x7w8cbcnj1eyz1nhnupf.jpeg')
  end

  it 'has a valid #thumbnail_url' do
    expect(receipt.thumbnail_url).to eq('http://res.cloudinary.com/dpquc2ssm/image/upload/w_250,h_250,c_fit/v1486788807/x7w8cbcnj1eyz1nhnupf.jpeg')
  end

  it 'has a valid #accountant_url' do
    expect(receipt.accountant_url).to eq('http://res.cloudinary.com/dpquc2ssm/image/upload/w_1000,h_1000,c_limit/v1486788807/x7w8cbcnj1eyz1nhnupf.jpeg')
  end

  context 'when a PDF' do
    let(:json) { { url: 'http://res.cloudinary.com/dpquc2ssm/image/upload/v1486788807/x7w8cbcnj1eyz1nhnupf.pdf' } }
    let(:receipt) { Receipt.new(request_item: request_item, cloudinary_json: json) }

    it 'has a valid #url' do
      expect(receipt.url).to eq('http://res.cloudinary.com/dpquc2ssm/image/upload/v1486788807/x7w8cbcnj1eyz1nhnupf.jpeg')
    end

    it 'has a valid #thumbnail' do
      expect(receipt.thumbnail_url).to eq('http://res.cloudinary.com/dpquc2ssm/image/upload/w_250,h_250,c_fit/v1486788807/x7w8cbcnj1eyz1nhnupf.jpeg')
    end
  end
end
