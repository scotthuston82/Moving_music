class Booking < ApplicationRecord

  belongs_to :musician, class_name: 'User'
  belongs_to :client, class_name: 'User'

  validates :address, presence: true
  validate :cannot_be_in_time_past
  validate :end_time_must_be_after_start


  def cannot_be_in_time_past
    if self[:start_time] > self[:end_time]
      errors.add(:custom_message, "The date cannot be in the past. Please try again.")
    end
  end

  def end_time_must_be_after_start
    if :start_time >= :end_time
      errors.add(:end_time, "Please choose an end time after the start time.")
    end
  end

end
