FactoryBot.define do
    factory :ticket do
        
        name { 'FakeTicket' }
        phone { '1-541-456-7890' }
        region_id { 1234 }
        resource_category_id{ 5678 }
        description{ 'Bend has a problem! Come help!' }
        closed { false }
        organization_id { nil }

    end

  end

#   #  validates_presence_of :name, :phone, :region_id, :resource_category_id
#   validates_length_of :name, minimum: 1, maximum: 255, on: :create
#   validates_length_of :description, maximum: 1020, on: :create
#   validates :phone, phony_plausible: true