class AddNullFalseToMeetupRecord < ActiveRecord::Migration
  def up
    change_column :meetup_records, :meetup_id, :integer, null: false
    change_column :meetup_records, :user_id, :integer, null: false
  end

  def down
    change_column :meetup_records, :meetup_id, :integer
    change_column :meetup_records, :user_id, :integer
  end
end
