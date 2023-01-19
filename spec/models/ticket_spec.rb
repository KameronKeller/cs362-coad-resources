require 'rails_helper'

RSpec.describe Ticket, type: :model do

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

end
