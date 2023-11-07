require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Posts index', type: :system do
  fixtures :users, :posts, :comments, :likes

  it 'displays post title' do
    visit user_post_path(users(:one), posts(:one))

    expect(page).to have_text('Test 1')
  end

  it 'displays the username' do
    visit user_post_path(users(:one), posts(:one))

    expect(page).to have_text('Ali')
  end

  it 'shows the number of comments and likes' do
    visit user_post_path(users(:one), posts(:one))

    expect(page).to have_text("Comments: #{posts(:one).comments.count}")
    expect(page).to have_text("Likes: #{posts(:one).likes.count}")
  end

  it 'displays the post text' do
    visit user_post_path(users(:one), posts(:one))

    expect(page).to have_text('Text 1')
  end

  it 'shows all commentor and comment text' do
    visit user_post_path(users(:one), posts(:one))

    allcomments = posts(:one).comments
    allcomments.each do |comment|
      expect(page).to have_text(comment.user.name)
      expect(page).to have_text(comment.text)
    end
  end
end
