require 'rails_helper'

RSpec.describe Organization, type: :model do
  # let(:organization) { Organization.new }
  let(:organization) { FactoryBot.build_stubbed(:organization)}

  it "has a name" do
    expect(organization).to respond_to(:name)
  end

  it "has a status" do
    expect(organization).to respond_to(:status)
  end

  it "has a phone" do
    expect(organization).to respond_to(:phone)
  end

  it "has an email" do
    expect(organization).to respond_to(:email)
  end

  it "has a description" do
    expect(organization).to respond_to(:description)
  end

  it "has a rejection_reason" do
    expect(organization).to respond_to(:rejection_reason)
  end

  it "has liability_insurance" do
    expect(organization).to respond_to(:liability_insurance)
  end

  it "has a primary_name" do
    expect(organization).to respond_to(:primary_name)
  end

  it "has a secondary_name" do
    expect(organization).to respond_to(:secondary_name)
  end

  it "has a secondary_phone" do
    expect(organization).to respond_to(:secondary_phone)
  end

  it "has a title" do
    expect(organization).to respond_to(:title)
  end

  it "has transportation" do
    expect(organization).to respond_to(:transportation)
  end

  it "has agreement_one" do
    expect(organization).to respond_to(:agreement_one)
  end

  it "has agreement_two" do
    expect(organization).to respond_to(:agreement_two)
  end

  it "has agreement_three" do
    expect(organization).to respond_to(:agreement_three)
  end

  it "has agreement_four" do
    expect(organization).to respond_to(:agreement_four)
  end

  it "has agreement_five" do
    expect(organization).to respond_to(:agreement_five)
  end

  it "has agreement_six" do
    expect(organization).to respond_to(:agreement_six)
  end

  it "has agreement_seven" do
    expect(organization).to respond_to(:agreement_seven)
  end

  it "has agreement_eight" do
    expect(organization).to respond_to(:agreement_eight)
  end

  describe 'associations' do
    it { should have_many(:users).class_name('User') }
    it { should have_many(:tickets).class_name('Ticket') }
    it { should have_and_belong_to_many(:resource_categories).class_name('ResourceCategory') }
  end

  describe 'validations' do
   
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:primary_name) }
    it { should validate_presence_of(:secondary_name) }
    it { should validate_presence_of(:secondary_phone) }
    
    it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
    
    it { should allow_value('12345@gmail.com').for(:email) }
    it { should allow_value('test-email@emailserver.com').for(:email) }
    it { should allow_value('testemail@emailserver.com').for(:email) }
    it { should_not allow_value('12345@gmail').for(:email) }
    it { should_not allow_value('@yahoo.com').for(:email) }
    it { should_not allow_value('custom_email@.com').for(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    
    it { should validate_uniqueness_of(:name).case_insensitive }
    
    it { should validate_length_of(:description).is_at_most(1020).on(:create) }
  end

  #METHODS
    it "can set status to approved" do
      organization.approve
      expect(organization.status).to eq("approved")
    end

    it "can set status to rejected" do
      organization.reject
      expect(organization.status).to eq("rejected")
    end

    it "can set default status to submitted" do
      organization.set_default_status
      expect(organization.status).to eq("submitted")
    end

    it "can return the name with to_s" do
      organization.name = "test_name"
      expect(organization.to_s).to eq("test_name")
    end

end

