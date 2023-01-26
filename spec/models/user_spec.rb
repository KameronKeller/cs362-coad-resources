require 'rails_helper'

RSpec.describe User, type: :model do

  it "has an email" do
    user = User.new
    expect(user).to respond_to(:email)
  end

  it "has an unconfirmed_email" do
    user = User.new
    expect(user).to respond_to(:unconfirmed_email)
  end

  it "has a role" do
    user = User.new
    expect(user).to respond_to(:role)
  end

  # describe 'associations' do
  #   it { should have_many(:tickets).class_name('Ticket') }
  # end

end
