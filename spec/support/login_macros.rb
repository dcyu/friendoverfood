module LoginMacros
  def log_in(user)
    visit root_path
    find('.l-header-nav.is-right').click_link "sign in"
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "Sign in"
  end
end