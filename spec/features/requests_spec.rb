require 'rails_helper'

feature 'Request', js: true, type: :feature do
  let(:user) { User.create! }
  let(:request) { Request.create!(user: user) }

  scenario 'visting new' do
    visit request_path(request)
    expect(page).to have_content "Expensely"
  end
end
