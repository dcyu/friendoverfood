require "spec_helper"

feature "User Actions" do


  feature "user sign up" do
    given(:create_club) {
      @club = FactoryGirl.create(:club)
      @admin_user = FactoryGirl.create(:user)
      admin_user_membership = FactoryGirl.create(:membership, user_id: @admin_user.id, club_id: @club.id, is_admin: true)
    }
    given(:sign_up) {    
      visit root_path
      find(".l-header-nav.is-right").click_link "sign up"
      user = FactoryGirl.build(:user)
      fill_in 'user_first_name', with: user.first_name 
      fill_in 'user_last_name', with: user.last_name
      select @club.name, from: 'user_pending_membership_club_id'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: "change123"
      fill_in 'user_password_confirmation', with: "change123"
      click_button 'Sign up'
    }
    given(:invalid_sign_up) {    
      visit root_path
      find(".l-header-nav.is-right").click_link "sign up"
      user = FactoryGirl.build(:user)
      fill_in 'user_first_name', with: user.first_name 
      fill_in 'user_last_name', with: user.last_name
      select @club.name, from: 'user_pending_membership_club_id'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: "change123"
      fill_in 'user_password_confirmation', with: "change1234"
      click_button 'Sign up'
    }

    scenario "actually adds a new user" do
      create_club
      expect{sign_up}.to change(User, :count).by(1)
    end

    scenario "redirects properly if valid" do
      create_club
      sign_up
      expect(current_path).to eq user_path(User.last)
    end

    scenario "redirects properly if invalid" do
      create_club
      invalid_sign_up
      expect(current_path).to eq users_path
    end

    scenario "adds one PendingMembership" do
      create_club
      expect{sign_up}.to change(PendingMembership, :count).by(1)
    end

    scenario "sends a welcome email to user" do
      create_club
      sign_up
      @email = open_last_email_for(User.last.email)
      expect(@email).to be_delivered_from "newfriendoverfood@gmail.com"
      expect(@email).to have_body_text User.last.first_name
    end

    scenario "sends a notice email to Admin" do
      create_club
      sign_up
      @email = open_last_email_for(@admin_user.email)
      expect(@email).to be_delivered_from "newfriendoverfood@gmail.com"
      expect(@email).to have_body_text User.last.first_name
      expect(@email).to have_body_text PendingMembership.last.club.name
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

  scenario "create a new club" do
  end

  scenario "request to join existing club" do
  end


end