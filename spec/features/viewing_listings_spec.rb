feature 'Viewing listings' do
  scenario 'a user can view listings' do

    connection = PG.connect(dbname: 'makers_bnb_test')
    connection.exec("INSERT INTO listings (name, description, price) VALUES('Minerva', 'A tiny house in the middle nowhere', 10.50);")

    listings = Listing.all

    visit '/'

    expect(page).to have_content 'Welcome to MakersBnB'
    expect(page).to have_content "Minerva A tiny house in the middle nowhere 10.50"
  end
end
