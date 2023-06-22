require 'rails_helper'

RSpec.describe User, type: :model do

  it "should validate user email" do
    user = User.create(
      email: nil,
      password: "password"
    )
    expect(user.errors[:email]).to_not be_empty
  end

  it "should validate password" do
    user = User.create(
      email: "test1@example.com",
      password: nil
    )
    expect(user.errors[:password]).to_not be_empty
  end

end
