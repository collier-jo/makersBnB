require 'database_helpers'

feature 'User profile page' do
  scenario 'a user can visit his profile page' do
    user_sign_in
    listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
    Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")

    visit '/'

    click_link 'My Account'
    expect(current_path).to eq "/users/#{User.current_user.username}/user"

    expect(page).to have_content 'username'
    expect(page).to have_content 'email@email.com'
    expect(page).to have_content 'Village House'
    expect(page).to have_content 'Lovely cottage in the countryside'
    expect(page).to have_css "img[src='https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg']"
  end
end
