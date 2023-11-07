require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Users show', type: :system do
  fixtures :users, :posts, :comments, :likes

  it 'displays profile picture' do
    visit user_path(users(:one))

    expect(page).to have_selector('img', count: 1)
  end

  it 'displays the username' do
    visit user_path(users(:one))

    expect(page).to have_text('Ali')
  end

  it 'displays the number of posts' do
    visit user_path(users(:one))

    expect(page).to have_text("Number of posts: #{users(:one).posts.count}")
  end

  it 'displays the bio' do
    visit user_path(users(:one))

    expect(page).to have_text('Bio')
    expect(page).to have_text(users(:one).bio)
  end

  it 'displays the user posts, maximum 3' do
    user = users(:one)
    visit user_path(user)

    user.three_most_recent_posts.each do |post|
      expect(page).to have_text(post.text)
    end
  end

  it 'displays a button to see all posts' do
    visit user_path(users(:one))

    expect(page).to have_selector('a', text: 'See all posts')
  end

  it 'when I click a post it shows the post page' do
    visit user_path(users(:one))

    expect(page).to have_selector('a', text: 'See all posts')
  end

  it 'after clicking see all posts button, it shows all posts page' do
    visit user_path(users(:one))

    click_link 'See all posts'

    expect(page).to have_current_path(user_posts_path(users(:one)))
  end
end
