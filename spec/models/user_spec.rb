require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a valid email' do
    user = User.new(email: 'john@example.com', password: 'password')
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user = User.new(email: nil, password: nil)
    expect(user).not_to be_valid
  end
end
