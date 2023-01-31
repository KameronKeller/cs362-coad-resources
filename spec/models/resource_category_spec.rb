require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

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




  # def self.unspecified
  #   ResourceCategory.find_or_create_by(name: 'Unspecified')
  # end
  it "should find or create an Unspecified ResourceCategory" do
    expect(ResourceCategory.unspecified.name).to eq('Unspecified')
  end


  # def activate
  #   self.update(active: true)
  # end

  # def deactivate
  #   self.update(active: false)
  # end

  # def inactive?
  #   !active?
  # end

  # def to_s
  #   name
  # end

end
