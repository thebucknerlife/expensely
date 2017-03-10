require 'rails_helper'

describe Request, type: :model do
  describe 'approved' do
    let(:scope) { Request.approved }

    context 'when not delivered' do
      let!(:request) { create :request, delivered_at: nil }

      it 'is not approved' do
        expect(scope).to_not include(request)
      end
    end

    context 'when delivered recently' do
      let!(:request) { create :request, delivered_at: 4.days.ago }

      it 'is not approved' do
        expect(scope).to_not include(request)
      end
    end

    context 'when delivered 5 days ago' do
      let!(:request) { create :request, delivered_at: 5.days.ago }

      it 'is approved' do
        expect(scope).to include(request)
      end
    end
  end
end
