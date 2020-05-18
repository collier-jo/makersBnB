require 'listing'

describe Listing do
  describe '.all' do
    it 'shows all the listings' do
      test = [
              'Test house: This is a test house, ppn: £50.',
              'Test another house: This is another test house, ppn: £45.'
            ]
      listings = Listing.all

      expect(listings).to eq test
    end
  end
end
