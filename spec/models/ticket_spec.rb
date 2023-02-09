require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:region) { FactoryBot.create(:region)}
  let(:resource_category) { FactoryBot.create(:resource_category) } 
  let(:organization) { FactoryBot.create(:organization)}
  let(:ticket) { FactoryBot.create(:ticket, region_id: region.id, resource_category_id: resource_category.id, organization_id: organization.id) }
  let(:open_ticket) { FactoryBot.create(:ticket, region_id: region.id, resource_category_id: resource_category.id) }
  let(:closed_ticket) { FactoryBot.create(:ticket, closed: true, region_id: region.id, resource_category_id: resource_category.id, organization_id: organization.id) }

  it "has a name" do
    expect(ticket).to respond_to(:name)
  end

  it "has a description" do
    expect(ticket).to respond_to(:description)
  end

  it "has a phone" do
    expect(ticket).to respond_to(:phone)
  end

  it "has a organization_id" do
    expect(ticket).to respond_to(:organization_id)
  end

  it "has closed" do
    expect(ticket).to respond_to(:closed)
  end

  it "has closed_at" do
    expect(ticket).to respond_to(:closed_at)
  end

  it "has a resource_category_id" do
    expect(ticket).to respond_to(:resource_category_id)
  end

  it "has a region_id" do
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
    expect(Ticket.open).to include(open_ticket)
  end

  it "returns closed tickets with :closed" do
    expect(Ticket.closed).to include(closed_ticket)
  end

  it "returns tickets for all organizations with :all_organization" do    
    expect(Ticket.all_organization).to include(ticket)
  end

  it "returns open tickets for a specific organization with :organization" do
    expect(Ticket.organization(organization.id)).to include(ticket)
  end

  it "returns tickets for all closed organizations" do
    expect(Ticket.closed_organization(organization.id)).to include(closed_ticket)
  end

  it "returns tickets for the region specified" do
    expect(Ticket.region(region.id)).to include(ticket)
  end


  it "returns tickets for a given resource_category" do
    expect(Ticket.resource_category(resource_category.id)).to include(ticket)

  end

end
