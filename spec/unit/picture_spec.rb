require 'picture'

describe Picture do
  describe '.create' do
    it 'submits a picture url to the database' do
      result = Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg')

      expect(result.url).to eq 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg'
    end
  end

  # describe '.find' do
  #   it ''
  # end
end
