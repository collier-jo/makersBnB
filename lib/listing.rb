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


  def self.create(name:, description:, price:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makers_bnb_test')
    else
      connection = PG.connect(dbname: 'makers_bnb')
    end
    connection.exec("INSERT INTO listings (name, description, price) VALUES('#{name}', '#{description}', '#{price}');")
  end
end
