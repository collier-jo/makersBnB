require 'pg'
require 'listing'

describe Listing do
  describe '.all' do
    it 'shows all the listings' do
      connection = PG.connect(dbname: 'makers_bnb_test')

      connection.exec("INSERT INTO listings (name, description, price) VALUES('Minerva', 'A tiny house in the middle nowhere', 10.50);")
      connection.exec("INSERT INTO listings (name, description, price) VALUES('Boat House', 'A boat house on the shores of lake Loch Ness', 35);")

      listings = Listing.all

      expect(listings).to include "Minerva"
      expect(listings).to include "A tiny house in the middle nowhere"
      expect(listings).to include "10.50"

      expect(listings).to include "Boat House"
      expect(listings).to include "A boat house on the shores of lake Loch Ness"
      expect(listings).to include "35.00"
    end
  end

end
