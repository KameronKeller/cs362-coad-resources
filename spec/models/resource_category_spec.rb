require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do
  let(:resource_category) { ResourceCategory.new }

  it "has a name" do
    resource_category = ResourceCategory.new
    expect(resource_category).to respond_to(:name)
  end

  it "has active" do
    resource_category = ResourceCategory.new
    expect(resource_category).to respond_to(:active)
  end

  describe 'associations' do
    it { should have_and_belong_to_many(:organizations).class_name('Organization') }
    it { should have_many(:tickets).class_name('Ticket') }
    
  end


  describe 'validations' do

    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }

    it { should validate_uniqueness_of(:name).case_insensitive }
    
  end



  #METHODS

  it "should find or create an Unspecified ResourceCategory" do
    expect(ResourceCategory.unspecified.name).to eq('Unspecified')
  end


  it "can set active to true" do
    resource_category.activate 
    expect(resource_category.active).to eq(true)
  end

  it "can set active to false" do
    resource_category.deactivate
    expect(resource_category.active).to eq(false)
  end

  it "can check if category is inactive" do
    resource_category.active = false
    expect(resource_category.inactive?).to eq(true)
  end

  it "can return the name with to_s" do
    resource_category.name = "test_name"
    expect(resource_category.to_s).to eq("test_name")
  end

end
