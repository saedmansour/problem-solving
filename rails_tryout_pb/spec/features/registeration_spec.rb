require 'rails_helper'

feature 'Sign up', :devise do
  scenario 'Register new user and returns success' do
  	user = FactoryGirl.build(:user)
    sign_up_with(user.email, user.password, user.password)
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Register new user with existing email returns failure' do
  	user = FactoryGirl.create(:user)
    sign_up_with(user.email, user.password, user.password)
    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'Register new user with not the same password' do
    user = FactoryGirl.build(:user)
    sign_up_with(user.email, user.password, Faker::Internet.password(8))
    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end
end

feature 'Sign in', :devise do
  scenario 'user cannot sign in if not registered' do
    user = FactoryGirl.build(:user)
    signin(user.email, user.password)
    expect(page).to have_content 'Invalid email or password.'
  end

  scenario 'user can sign in with valid credentials' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'user cannot sign in with wrong email' do
    user = FactoryGirl.create(:user)
    signin('invalid@email.com', user.password)
    expect(page).to have_content 'Invalid email or password.'
  end

  scenario 'user cannot sign in with wrong password' do
    user = FactoryGirl.create(:user)
    signin(user.email, 'invalidpass')
    expect(page).to have_content 'Invalid email or password.'
  end
end