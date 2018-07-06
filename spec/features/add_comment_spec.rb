feature 'add comment' do
  scenario 'adding a comment to a bookmark' do
    visit('/')
    fill_in('title', with: 'Facebook')
    fill_in('url', with: 'http://facebook.com')
    click_button('Add bookmark')
    click_button('Add comment', match: :first)
    fill_in('comment', with: 'This is a comment.')
    click_button('Submit')
    expect(page).to have_content 'This is a comment.'
  end
end
