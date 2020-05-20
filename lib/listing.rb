require 'pg'

class Listing

  attr_reader :id, :name, :description, :price, :user_id

  def initialize(id:, name:, description:, price:, user_id:)
    @id = id
    @name = name
    @description = description
    @price = price
    @user_id = user_id
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM listings;")
    result.map do |listing|
      Listing.new(id: listing['id'], name: listing['name'],
        description: listing['description'], price: listing['price'])
    end
  end

  def self.create(name:, description:, price:)
    result = DatabaseConnection.query("INSERT INTO listings (name, description, price, user_id)
      VALUES('#{name}', '#{description}', '#{price}', '#{User.current_user.id}') RETURNING id, name, description, price, user_id;")
    Listing.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'],
      price: result[0]['price'], user_id: result[0]['user_id'])
  end
end
