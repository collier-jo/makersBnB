require 'pg'
require 'listing'

describe Listing do
  describe '.all' do
    it 'shows all the listings' do
      connection = PG.connect(dbname: 'makers_bnb_test')

      listing = connection.exec("INSERT INTO listings (name, description, price) VALUES('Minerva', 'A tiny house in the middle nowhere', 10.50);")
      connection.exec("INSERT INTO listings (name, description, price) VALUES('Boat House', 'A boat house on the shores of lake Loch Ness', 35);")

      listings = Listing.all

      expect(listings.first.name).to include "Minerva"
      expect(listings.first.description).to include "A tiny house in the middle nowhere"
      expect(listings.first.price).to include "10.50"
      expect(listings.length).to eq(2)
    end
  end

  describe '.create' do
    it 'lets a user create a new listing' do
      listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')

      expect(listing.name).to include "Village House"
      expect(listing.description).to include "Lovely cottage in the countryside"
      expect(listing.price).to include "50.00"
    end
  end
end
