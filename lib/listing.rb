require 'pg'

class Listing

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makers_bnb_test')
    else
      connection = PG.connect(dbname: 'makers_bnb')
    end
    result = connection.exec('SELECT * FROM listings;')
    arr = []
    result.each do |listing|
      arr.push(listing["name"])
      arr.push(listing["description"])
      arr.push(listing["price"])
    end
    return arr
  end
end

  #
  # def self.all     if ENV['ENVIRONMENT'] == 'test' 
  #   connection = PG.connect(dbname: 'bookmark_manager_test')     else 
  #   connection = PG.connect(dbname: 'bookmark_manager')     end 
  #    bookmarks = connection.exec('SELECT * FROM bookmarks;') 
  #    bookmarks.map { |bookmark| bookmark['url'] }   end
