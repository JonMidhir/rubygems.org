require 'test_helper'

class SignInTest < SystemTest
  setup do
    create(:user, email: "nick@example.com", password: "secret123")
  end

  test "signing in" do
    visit sign_in_path
    fill_in "Email or Handle", with: "nick@example.com"
    fill_in "Password", with: "secret123"
    click_button "Sign in"

    assert page.has_content? "Sign out"
  end

  test "signing in with uppercase email" do
    visit sign_in_path
    fill_in "Email or Handle", with: "Nick@example.com"
    fill_in "Password", with: "secret123"
    click_button "Sign in"

    assert page.has_content? "Sign out"
  end

  test "signing in with wrong password" do
    visit sign_in_path
    fill_in "Email or Handle", with: "nick@example.com"
    fill_in "Password", with: "secret"
    click_button "Sign in"

    assert page.has_content? "Sign in"
    assert page.has_content? "Bad email or password"
  end

  test "signing in with wrong email" do
    visit sign_in_path
    fill_in "Email or Handle", with: "someone@example.com"
    fill_in "Password", with: "secret"
    click_button "Sign in"

    assert page.has_content? "Sign in"
    assert page.has_content? "Bad email or password"
  end

  test "signing out" do
    visit sign_in_path
    fill_in "Email or Handle", with: "nick@example.com"
    fill_in "Password", with: "secret123"
    click_button "Sign in"

    click_link "Sign out"

    assert page.has_content? "Sign in"
  end
end
