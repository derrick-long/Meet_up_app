class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |table|
      table.string :description
      table.string :meetup_name, null: false
      table.integer :meetup_creator, null:false
    end
  end
end
