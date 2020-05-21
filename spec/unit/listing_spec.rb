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

  describe '.find' do
    it 'lets the user view listing in full' do
      listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')

      result = Listing.find(id: "#{listing.id}")

      expect(result.id).to eq listing.id
      expect(result.name).to eq "Village House"
      expect(result.description).to eq "Lovely cottage in the countryside"
      expect(result.price).to eq "50.00"
    end
  end

  describe '#pictures' do
    it 'integrates pictures to the listing' do
      listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
      Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")

      picture = listing.pictures.first

      expect(picture['listing_id']).to eq listing.id
    end
  end
end
