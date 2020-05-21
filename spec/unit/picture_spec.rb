require 'picture'

describe Picture do
  describe '.create' do
    it 'submits a picture url to the database' do
      listing = Listing.create(name: 'Minerva', description: 'A really fun place on the surface of the sun', price: '25.00')
      picture = Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")

      expect(listing.id).to eq picture.listing_id
      expect(picture.url).to eq 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg'
    end
  end

  # describe '.find' do
  #   it ''
  # end
end
