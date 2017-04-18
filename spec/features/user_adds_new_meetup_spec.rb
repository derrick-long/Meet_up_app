require 'spec_helper'

feature 'user adds a meetup' do


  scenario "user successfully adds a new meetup" do
    visit '/meetups/new'
    fill_in 'meetup_name', with: 'The rad dude meetup'
    fill_in 'meetup_location', with: 'Wherever rad dudes are'
    fill_in 'meetup_creator', with: 'A rad dude'
    fill_in 'meetup_description', with: 'Where rad dudes meet other rad dudes for radness'
    click_button 'Create Meetup'

    expect(page).to have_content('New meetup added!')
  end
  #so apparently it takes double clicks right now, so that sucks lol
  scenario "user forgets to fill in the meetup name" do
    visit '/meetups/new'
    fill_in 'meetup_name', with:" "
    fill_in 'meetup_location', with: 'Wherever rad dudes are'
    fill_in 'meetup_creator', with: 'A rad dude'
    fill_in 'meetup_description', with: 'Where rad dudes meet other rad dudes for radness'
    click_button 'Create Meetup'
    click_button 'Create Meetup'
    expect(page).to have_content("Meetup name can't be blank.")
  end

end
