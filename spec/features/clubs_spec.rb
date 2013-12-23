require "spec_helper"

feature "Club Actions user can" do
  given(:create_club) {
    click_link "Join More Clubs"
    click_link "Create New Club"
    fill_in 'club_name', with: "Dining Crew"
    fill_in 'club_description', with: "Dining Crew in the vast majority of cases, that the story is tendentious or over-sold."
    click_button "Save"
  }
  background do
    log_in
  end

  scenario "create a new club" do
    expect{create_club}.to change(Club, :count).by(1)
    expect(current_path).to eq club_path(Club.last)
    expect(Club.last.name).to eq "Dining Crew"
  end

  scenario "delete club" do
    create_club
    expect{click_link "Delete"}.to change(Club, :count).by(-1)
    expect(current_path).to eq clubs_path
  end

  scenario "edit club" do
    create_club
    click_link "Edit Description"
    fill_in 'club_name', with: "Da Club" 
    fill_in 'club_description', with: "What a lame description."
    find(".actions").click_button 'Save'
    expect(current_path).to eq club_path(Club.last)
    updated_club = Club.last
    expect(updated_club.name).to eq "Da Club"
    expect(updated_club.description).to eq "What a lame description."
  end

  scenario "request to join existing club" do
  end


end