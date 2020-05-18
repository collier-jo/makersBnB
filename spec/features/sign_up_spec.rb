feature 'User sign up' do
  scenario 'A user can sign up' do
    visit('/signup')

    expect(page).to have_content "Sign Up"
  end
end
