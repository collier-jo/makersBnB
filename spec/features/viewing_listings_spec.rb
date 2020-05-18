feature 'Viewing listings' do
  scenario 'a user can view listings' do

    visit '/'

    expect(page).to have_content 'Welcome to MakersBnB'
    expect(page).to have_content 'Test house: This is a test house, ppn: £50.'
    expect(page).to have_content 'Test another house: This is another test house, ppn: £45.'
  end
end
