require 'pg'
def persisted_data(id:)
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.query("SELECT * FROM users WHERE id = #{id};")
end