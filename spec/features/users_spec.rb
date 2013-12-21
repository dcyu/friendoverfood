require "spec_helper"

feature "User Actions" do


  feature "user sign up" do
    given(:sign_up) {    
      visit root_path
      club = FactoryGirl.create(:club)
      find(".l-header-nav.is-right").click_link "sign up"
      user = FactoryGirl.build(:user)
      fill_in 'user_first_name', with: user.first_name 
      fill_in 'user_last_name', with: user.last_name
      select club.name, from: 'user_pending_membership_club_id'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: "change123"
      fill_in 'user_password_confirmation', with: "change123"
      click_button 'Sign up'
    }
    given(:invalid_sign_up) {    
      visit root_path
      club = FactoryGirl.create(:club)
      find(".l-header-nav.is-right").click_link "sign up"
      user = FactoryGirl.build(:user)
      fill_in 'user_first_name', with: user.first_name 
      fill_in 'user_last_name', with: user.last_name
      select club.name, from: 'user_pending_membership_club_id'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: "change123"
      fill_in 'user_password_confirmation', with: "change1243"
      click_button 'Sign up'
    }

    scenario "actually adds a new user" do
      expect{sign_up}.to change(User, :count).by(1)
    end

    scenario "redirects properly if valid" do
      sign_up
      expect(current_path).to eq user_path(User.last)
    end

    scenario "redirects properly if invalid" do
      invalid_sign_up
      expect(current_path).to eq users_path
    end

    scenario "adds one PendingMembership" do
      expect{sign_up}.to change(PendingMembership, :count).by(1)
    end

    scenario "sends a welcome email to user" do
      sign_up
      @email = open_last_email_for(@user.email)
      expect(@email).to be_delivered_from "welcome@bosoul.com"
    end

    scenario "sends a notice email to Admin" do
      sign_up
      @email = open_last_email_for("nishta.boodhoo@gmail.com")
      expect(@email).to be_delivered_from "info@bosoul.com"
    end

  end

  scenario "signs in user" do
    user = FactoryGirl.create(:user)
    log_in user
    expect(current_path).to eq user_path(user.id)
  end

  scenario "user can edit their personal info" do
    user = FactoryGirl.create(:user)
    log_in user
    visit edit_user_path(user)
    fill_in 'user_first_name', with: "John" 
    fill_in 'user_last_name', with: "Smith"
    fill_in 'user_email', with: "johnsmith@johnsmith.com"
    fill_in 'user_password', with: "abc123"
    fill_in 'user_password_confirmation', with: "abc123"
    find(".actions").click_button 'Update Info'
    expect(current_path).to eq user_path(user.id)
    updated_user = User.find(user.id)
    expect(updated_user.first_name).to eq "John"
    expect(updated_user.last_name).to eq "Smith"
  end


end