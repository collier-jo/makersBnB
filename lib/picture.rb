class Picture

  attr_reader :id, :url

  def initialize(id:, url:)
    @id = id
    @url = url
  end

  def self.create(url:)
    result = DatabaseConnection.query("INSERT INTO pictures (url) VALUES('#{url}') RETURNING id, url;")
    Picture.new(id: result[0]['id'], url: result[0]['url'])
  end
end
