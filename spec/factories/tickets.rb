FactoryBot.define do
    factory :ticket do
        
        name { 'FakeTicket' }
        phone { '1-541-456-7890' }
        region_id { create(:region).id }
        resource_category_id{ create(:resource_category).id }
        description{ 'Bend has a problem! Come help!' }
        closed { false }
        organization_id { nil }

    end

  end