module LoginMacros
  def log_in
    @current_user = FactoryGirl.create(:user, password: "abc123", password_confirmation: "abc123")
    visit root_path
    find('.l-header-nav.is-right').click_link "sign in"
    fill_in "email", with: @current_user.email
    fill_in "password", with: "abc123"
    click_button "Sign in"
  end
end