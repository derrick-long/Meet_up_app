class Meetup < ActiveRecord::Base
  has_many :meetup_records
  has_many :users, :through => :meetup_records

  validates :meetup_name, presence: true
  validates :meetup_creator, presence: true
end

#ask about functionality here
