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
    refute user.persisted?, "user should not persist without email present"
  end

  test "kind must be present" do
    user = build(:user, kind: nil)
    user.save
    refute user.persisted?, "user should not persist if kind is nil"
  end

  test "kind must only be musician or client" do
    user = build(:user, kind: 'another kind')
    user.save
    refute user.persisted?, "user should not persist if kind is not 'musician' or 'client'"
  end

  test "musician act_type can only be dj or band" do
    user = create(:user)
    user.update(act_type: 'another type')
    assert user.invalid?, "user should not save if act type is not 'dj' or 'band'"
  end

  test "hourly rate must be greater than zero" do
    user = create(:user)
    user.update(hourly_rate: 0)
    assert user.invalid?, "user hourly_rate must be greater than zero"
  end

  test "musician address must be valid" do
    user = create(:user)
    user.update(address: 'adlfkjdfkei')
    assert user.invalid?, "user should be invalid if address is invalid"
  end

end
