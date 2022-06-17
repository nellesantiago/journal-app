require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:user)
  end

  test "sign up" do
    visit new_user_registration_path
    fill_in "user[email]", with: "test@test.com" 
    fill_in "user[password]", with:  "1234567890"
    fill_in "user[password_confirmation]", with:  "1234567890" 
    click_on "Sign up"
    assert_text "Task Categories"
  end

  test "sign in" do
    sign_in @user
    visit categories_url
    assert_text "Task Categories"
  end
end
