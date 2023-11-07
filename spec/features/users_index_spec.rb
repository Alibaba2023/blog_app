require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Users index', type: :system do
  fixtures :users, :posts

  it 'displays all the users' do
    visit users_path
    sleep(1)

    expect(page).to have_text('Ali')
    expect(page).to have_text('Tom')
  end

  it 'displays the profile pictures' do
    visit users_path

    expect(page).to have_selector('img', count: 2)
  end

  it 'displays the number of posts for user' do
    visit users_path

    expect(page).to have_text("Number of posts: #{users(:one).posts.count}")
  end

  it 'redirects to the user profile page' do
    visit users_path
    click_link users(:one).name

    expect(page).to have_current_path(user_path(users(:one)))
  end
end
