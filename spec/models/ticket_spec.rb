require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:ticket) { Ticket.new }

  it "has a name" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:name)
  end

  it "has a description" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:description)
  end

  it "has a phone" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:phone)
  end

  it "has a organization_id" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:organization_id)
  end

  it "has closed" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:closed)
  end

  it "has closed_at" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:closed_at)
  end

  it "has a resource_category_id" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:resource_category_id)
  end

  it "has a region_id" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:region_id)
  end

  describe 'associations' do
    # it { should have_many(:region).class_name('Region') }
    it { should belong_to(:region)} #no class name purposefully left out to test if .class_name makes a difference ^ see above format
    it { should belong_to(:resource_category)}
    it { should belong_to(:organization).optional }
  end


  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:region_id) }
    it { should validate_presence_of(:resource_category_id) }

    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }

    it { should validate_length_of(:description).is_at_most(1020).on(:create) }

    it { should allow_value('1-541-456-7890').for(:phone) }
    it {  allow_value('1-111-111-1111').for(:phone) }
    it { should_not allow_value('123l').for(:phone) }

    it "validates phone using phony_plausible" do
      expect(Ticket.validators_on(:phone)).to include(PhonyPlausibleValidator)
    end
  end

  # METHODS:

  it "can check if ticket is open" do
    ticket.closed = false
    expect(ticket.open?).to eq(true)
  end

  it "can check if ticket is captured by org" do
    ticket.closed = false
    expect(ticket.open?).to eq(true)
  end

  it "can return the ticket with its id with to_s" do
    ticket.id = 1234
    expect(ticket.to_s).to eq("Ticket 1234")
  end

 # SCOPE:

  it "returns open tickes with :open" do
    region = Region.create(name: "test_region")
    resource_category = ResourceCategory.create(name: "test_category")

    ticket = Ticket.create! :closed => false, :region => region, :resource_category => resource_category,
                            :organization_id => nil, :name => "test", :phone => "1-541-456-7890"
    expect(Ticket.open).to include(ticket)
  end

  it "returns closed tickets with :closed" do
    region = Region.create(name: "test_region")
    resource_category = ResourceCategory.create(name: "test_category")

    ticket = Ticket.create! :closed => true, :region => region, :resource_category => resource_category,
                            :organization_id => nil, :name => "test", :phone => "1-541-456-7890"
    expect(Ticket.closed).to include(ticket)
  end

  it "returns tickets for all organizations with :all_organization" do
    region = Region.create(name: "test_region")
    resource_category = ResourceCategory.create(name: "test_category")
    organization = Organization.create(name: "test_organization", email: "test@test.com", id: 1234)

    ticket = Ticket.create! :closed => false, :region => region, :resource_category => resource_category,
                            :organization => organization, :name => "test", :phone => "1-541-456-7890"
    
    expect(Ticket.all_organization).to include(ticket)
  end

  it "returns open tickets for a specific organization with :organization" do
    region = Region.create(name: "test_region")
    resource_category = ResourceCategory.create(name: "test_category")
    organization = Organization.create(name: "test_organization", email: "test@test.com", id: 1234)

    ticket = Ticket.create! :closed => false, :region => region, :resource_category => resource_category,
                            :organization => organization, :name => "test", :phone => "1-541-456-7890"
    
    expect(Ticket.organization(1234)).to include(ticket)
  end

  # scope :open, -> () { where closed: false, organization_id: nil }


  # it "returns resource categories with active" do
  #   resource_category = ResourceCategory.create! :active => true, :name => "test"
  #   expect(ResourceCategory.active).to include(resource_category)
  # end
  # it "can check open status" do
  #   testing = Ticket.create! :open => true
  # end


  # scope :closed, -> () { where closed: true }
  # scope :all_organization, -> () { where(closed: false).where.not(organization_id: nil) }
  # scope :organization, -> (organization_id) { where(organization_id: organization_id, closed: false) }
  # scope :closed_organization, -> (organization_id) { where(organization_id: organization_id, closed: true) }
  # scope :region, -> (region_id) { where(region_id: region_id) }
  # scope :resource_category, -> (resource_category_id) { where(resource_category_id: resource_category_id) }



end
