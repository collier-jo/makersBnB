require 'pg'

class User
    attr_reader :id, :email, :username
  def initialize(id:, email:, username:)
    @id = id
    @email = email
    @username = username
  end
  def self.create(email:, username:, password:)
    result = DatabaseConnection.query("INSERT INTO users (email, username, password)
      VALUES('#{email}', '#{username}', '#{password}' ) RETURNING id, email, username;")
    User.new(id: result[0]['id'], email: result[0]['email'], username: result[0]['username'])
  end
end