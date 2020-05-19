require 'pg'
require 'listing'

describe Listing do
  describe '.all' do
    it 'shows all the listings' do
      connection = PG.connect(dbname: 'makers_bnb_test')
    
      connection.exec("INSERT INTO listings (name, description, price) VALUES('Minerva', 'A tiny house in the middle nowhere', 10.50);")
      listings = Listing.all
      expect(listings).to include "Minerva"
      expect(listings).to include "A tiny house in the middle nowhere"
      expect(listings).to include "10.50"
    end
  end
end