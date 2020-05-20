feature 'User sign up' do
  scenario 'A user can sign up' do
    sign_up
    # still needs expect(page).to have_content ...
  end

  scenario 'An email/username already exists' do
    User.create(
      email: 'email@email.com',
      password: 'password123',
      username: 'user1'
    )
    sign_up
    expect(page).to have_content "this username/email already exists"
  end
end
