feature 'Viewing listings' do
  scenario 'a user can view listings' do

    connection = PG.connect(dbname: 'makers_bnb_test')
    connection.exec("INSERT INTO listings (name, description, price) VALUES('Minerva', 'A tiny house in the middle nowhere', 10.50);")
    connection.exec("INSERT INTO listings (name, description, price) VALUES('Boat House', 'A boat house on the shores of lake Loch Ness', 35);")

    listings = Listing.all

    visit '/'

    expect(page).to have_content 'Welcome to MakersBnB'
    expect(page).to have_content "Minerva A tiny house in the middle nowhere 10.50"
    expect(page).to have_content "Boat House A boat house on the shores of lake Loch Ness 35.00"
  end

  scenario 'a user can select button to visit listings/new' do
    visit '/'

    expect(page).to have_button "Add Listing"

    click_button 'Add Listing'

    expect(current_path).to eq '/listings/new'
  end

  scenario 'a user can sign in' do
    visit '/'

    expect(page).to have_button 'Sign In'

    click_button 'Sign In'

    expect(current_path).to eq '/sessions/new'
  end
end
