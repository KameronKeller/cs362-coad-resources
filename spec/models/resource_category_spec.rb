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

end
