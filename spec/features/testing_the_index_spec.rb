require 'spec_helper'

feature 'user lands at the index page' do
  scenario 'User sees a list of meetups in alphabetical order' do
#might be difficult to actually write a test for this lol

  end

  scenario 'User clicks on the add a meetup link' do
    visit '/'
    click_link 'Add a New Meetup!'
    expect(page).to have_content ("Meetup Name")
  end

  scenario 'User clicks a link of  created meetup on the index page' do
    visit '/meetups/new'
    fill_in 'meetup_name', with: 'The rad dude meetup'
    fill_in 'meetup_location', with: 'Wherever rad dudes are'
    fill_in 'meetup_creator', with: 'A rad dude'
    fill_in 'meetup_description', with: 'Where rad dudes meet other rad dudes for radness'
    click_button 'Create Meetup'
    click_link 'The rad dude meetup'
    expect(page).to have_content ("Location: Wherever rad dudes are")

  end





end
