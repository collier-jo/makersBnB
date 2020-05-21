require 'listing'
require './lib/user.rb'
require 'database_helpers'

describe Listing do
  describe '.all' do
    it 'shows all the listings' do
      user_sign_in
      listing = Listing.create(name: 'Minerva', description: 'A tiny house in the middle nowhere', price: '10.50')
      Listing.create(name: 'Boat House', description: 'A boat house on the shores of lake Loch Ness', price: '35.00')

      listings = Listing.all

      expect(listings.length).to eq 2
      expect(listings.first).to be_a Listing
      expect(listings.first.id).to eq listing.id
      expect(listings.first.name).to include "Minerva"
      expect(listings.first.description).to include "A tiny house in the middle nowhere"
      expect(listings.first.price).to include "10.50"
    end
  end

  describe '.create' do
    it 'lets a user create a new listing' do
      user_sign_in
      listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
      persisted_data = persisted_data(table: :listings, id: listing.id)

      expect(listing).to be_a Listing
      expect(listing.id).to eq persisted_data.first['id']
      expect(listing.name).to include "Village House"
      expect(listing.description).to include "Lovely cottage in the countryside"
      expect(listing.price).to include "50.00"
    end

  it 'accesses the user_id from the user table' do
    user_sign_in
    listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
    expect(listing.user_id).to eq(User.current_user.id)
  end
end
end
