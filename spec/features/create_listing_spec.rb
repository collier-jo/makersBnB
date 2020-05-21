feature 'Create Listing' do
  scenario 'a user can submit a listing to website' do
    user = User.create(username: 'username', email: 'email@email.com', password: 'test_password')
    authenticated_user = User.authenticate(username: 'username',password: 'test_password')
    visit '/'
    click_button "Add Listing"

    expect(page).to have_content 'Add new listing'
    fill_in('name', with: 'Fun House')
    fill_in('description', with: 'A really fun place on the surface of the sun')
    fill_in('price', with: '100.00')
    click_button 'Submit'

    expect(current_path).to eq '/'
    expect(page).to have_content 'Your listing has been added'
    expect(page).to have_content 'Fun House A really fun place on the surface of the sun 100.00'
  end
end
