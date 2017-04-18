class AssociateMeetupsAndUsersThroughMeetupRecords < ActiveRecord::Migration
  def change
    create_table :meetup_records do |t|
       t.belongs_to :meetup, index: true
       t.belongs_to :user, index: true
    end 
  end
end
