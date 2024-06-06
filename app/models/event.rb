class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :event_attendances
  has_many :attendees, class_name: 'User', through: :event_attendances
end
