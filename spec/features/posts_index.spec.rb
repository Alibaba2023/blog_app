require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Posts index', type: :system do
  fixtures :users, :posts, :comments, :likes

  it 'displays profile picture' do
    visit user_posts_path(users(:one))

    expect(page).to have_selector('img', count: 1)
  end

  it 'displays the first comment on a post' do
    visit user_posts_path(users(:one))

    # Find the first post element on the page
    first_post_element = first('ul.user-posts-list .posts-comments-box')

    # Find the first comment element within the first post
    first_comment_element = first_post_element.find('.comments-box p')

    # Get the text content of the first comment element
    first_comment_text = first_comment_element.text

    expect(first_comment_text).to_not be_empty
  end


  it 'displays the username' do
    visit user_posts_path(users(:one))

    expect(page).to have_text('Ali')
  end

  it 'displays the number of posts' do
    visit user_posts_path(users(:one))

    expect(page).to have_text("Number of posts: #{users(:one).posts.count}")
  end

  it 'displays the user posts' do
    visit user_posts_path(users(:one))

    allposts = users(:one).posts
    allposts.each do |post|
      expect(page).to have_text(post.title)
      expect(page).to have_text(post.text)
    end
  end

  it 'shows the number of comments and likes' do
    visit user_posts_path(users(:one))

    expect(page).to have_text("Comments: #{posts(:one).comments.count}")
    expect(page).to have_text("Likes: #{posts(:one).likes.count}")
  end

  it 'displays a button to see more posts' do
    visit user_posts_path(users(:one))

    expect(page).to have_selector('a', text: 'See all posts')
  end

  it 'when I click a post it shows the post page' do
    visit user_posts_path(users(:one))

    click_link 'Test 1'

    expect(page).to have_current_path(user_post_path(users(:one), posts(:one)))
  end
end
