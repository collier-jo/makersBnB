feature 'User sign up' do
  scenario 'A user can sign up' do
    visit('/signup')

    expect(page).to have_content "Sign Up"
    fill_in('username', with: 'user1')
    fill_in('email', with: 'email@email.com')
    fill_in('password', with: 'password123')
    click_button('Register')
  end

  scenario 'An email/username already exists' do
    User.create(
      email: 'email@email.com',
      password: 'password123',
      username: 'user1'
    )
    visit('/signup')
    fill_in('username', with: 'user1')
    fill_in('email', with: 'email@email.com')
    fill_in('password', with: 'password123')
    click_button('Register')
    expect(page).to have_content "this username/email already exists"
  end
end
