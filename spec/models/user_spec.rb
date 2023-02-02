require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }

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

  describe 'associations' do
    it { should belong_to(:organization).optional }
  end

  describe 'validations' do
   
    it { should validate_presence_of(:email) }
    
    it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
    
    it { should allow_value('12345@gmail.com').for(:email) }
    it { should allow_value('test-email@emailserver.com').for(:email) }
    it { should allow_value('testemail@emailserver.com').for(:email) }
    it { should_not allow_value('12345@gmail').for(:email) }
    it { should_not allow_value('@yahoo.com').for(:email) }
    it { should_not allow_value('custom_email@.com').for(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password).on(:create)  }

    it { should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create)  }
    
  end

  #METHODS:

  it "can confirm role has been set" do
    user.role = "admin"
    expect(user.set_default_role).to eq("admin")
  end

  it "can set default organization when empty" do
    expect(user.set_default_role).to eq("organization")
  end


  it "can return the user email with to_s" do
    user.email = "test_name@test.com"
    expect(user.to_s).to eq("test_name@test.com")
  end

end
