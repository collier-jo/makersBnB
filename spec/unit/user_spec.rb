require 'user'
require 'database_helpers'
describe User do
    describe '.create' do
      it 'creates a new user' do
        user = User.create(
            email: 'email@email.com', 
        password: 'Password123', 
        username: 'username'
        )
        persisted_data = persisted_data(id: user.id)
      expect(user).to be_a User
      expect(user.id).to eq persisted_data.first['id']
      expect(user.email).to eq 'email@email.com'
      expect(user.username).to eq 'username'
      end
    end
  end