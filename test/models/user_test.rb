require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a valid user can be created" do
    user = build(:user)
    user.save
    assert user.persisted?
  end

  test "email must be unique" do
    user1 = build(:user)
    user2 = build(:user, email: user1.email)
    user1.save
    user2.save
    refute user2.persisted?
  end

  test "email must be present" do
    user = build(:user, email: nil)
    user.save
    refute user.persisted?
  end
end
