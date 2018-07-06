feature 'add tag' do
  scenario 'adding a tag to a bookmark' do
    visit('/')
    fill_in('title', with: 'Facebook')
    fill_in('url', with: 'http://facebook.com')
    click_button('Add bookmark')
    click_button('Add tag', match: :first)
    fill_in('tag', with: 'social')
    click_button('Submit')
    expect(page).to have_content 'social'
  end
end
