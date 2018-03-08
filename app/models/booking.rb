class Booking < ApplicationRecord

  belongs_to :musician, class_name: 'User'
  belongs_to :client, class_name: 'User'
  has_one :review

  validates :address, :event_name, presence: true
  validate :start_time_cannot_be_in_time_past
  validate :end_time_must_be_after_start


  def start_time_cannot_be_in_time_past
    if self[:start_time] < Time.now
      errors.add(:start_time, "The start date cannot be in the past. Please try again.")
    end
  end

  def end_time_must_be_after_start
    if self[:end_time] <= self[:start_time]
        errors.add(:end_time, "Please choose an end time after the start time.")
    end
  end

end
