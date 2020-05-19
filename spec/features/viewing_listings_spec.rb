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
end
