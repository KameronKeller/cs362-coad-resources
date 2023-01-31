require 'rails_helper'

RSpec.describe Region, type: :model do
  let(:region) { Region.new }

  it "has a name" do
    region = Region.new
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = Region.new(name: name)
    result = region.to_s
  end

  describe 'associations' do
    it { should have_many(:tickets).class_name('Ticket') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }

    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  #METHODS
  it "should find or create an Unspecified region" do
    expect(Region.unspecified.name).to eq('Unspecified')
  end

  it "can return the name with to_s" do
    region.name = "test_name"
    expect(region.to_s).to eq("test_name")
  end

end
