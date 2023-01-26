require 'rails_helper'

RSpec.describe Organization, type: :model do

  it "has a name" do
    organization = Organization.new
    expect(organization).to respond_to(:name)
  end

  it "has a status" do
    organization = Organization.new
    expect(organization).to respond_to(:status)
  end

  it "has a phone" do
    organization = Organization.new
    expect(organization).to respond_to(:phone)
  end

  it "has an email" do
    organization = Organization.new
    expect(organization).to respond_to(:email)
  end

  it "has a description" do
    organization = Organization.new
    expect(organization).to respond_to(:description)
  end

  it "has a rejection_reason" do
    organization = Organization.new
    expect(organization).to respond_to(:rejection_reason)
  end

  it "has liability_insurance" do
    organization = Organization.new
    expect(organization).to respond_to(:liability_insurance)
  end

  it "has a primary_name" do
    organization = Organization.new
    expect(organization).to respond_to(:primary_name)
  end

  it "has a secondary_name" do
    organization = Organization.new
    expect(organization).to respond_to(:secondary_name)
  end

  it "has a secondary_phone" do
    organization = Organization.new
    expect(organization).to respond_to(:secondary_phone)
  end

  it "has a title" do
    organization = Organization.new
    expect(organization).to respond_to(:title)
  end

  it "has transportation" do
    organization = Organization.new
    expect(organization).to respond_to(:transportation)
  end

  it "has agreement_one" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_one)
  end

  it "has agreement_two" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_two)
  end

  it "has agreement_three" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_three)
  end

  it "has agreement_four" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_four)
  end

  it "has agreement_five" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_five)
  end

  it "has agreement_six" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_six)
  end

  it "has agreement_seven" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_seven)
  end

  it "has agreement_eight" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_eight)
  end

  describe 'associations' do
    it { should have_many(:users).class_name('User') }
    it { should have_many(:tickets).class_name('Ticket') }
    it { should have_and_belong_to_many(:resource_categories).class_name('ResourceCategory') }
  end


end

