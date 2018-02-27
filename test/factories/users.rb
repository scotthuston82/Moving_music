FactoryBot.define do
  factory :user do
    first_name            'Sally'
    last_name             'Lowenthal'
    sequence(:email)      {|num| "sally#{num}@example.com"}
    password              'passpass'
    password_confirmation 'passpass'
    kind                  'musician'
    act_type              'dj'
    hourly_rate           '200'

    trait :client do
      kind                'client'
    end
  end
end
