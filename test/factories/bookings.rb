FactoryBot.define do
  factory :booking do
    address         "220 King St West Toronto, ON"
    start_time      Time.now + 2.days
    end_time        Time.now + 2.days + 3.hours
    party_size      100
    age_range       "19+"
    # user
    # client_user
  end
end
