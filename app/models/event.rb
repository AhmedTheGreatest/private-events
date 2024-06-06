class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :event_attendances
  has_many :attendees, class_name: 'User', through: :event_attendances, source: :attendee

  scope :past, -> { where('date < ?', Date.today).order(date: :desc) }
  scope :future, -> { where('date >= ?', Date.today).order(date: :asc) }

  validates :creator, presence: true
  validates :date, presence: true
  validates :name, presence: true
end
