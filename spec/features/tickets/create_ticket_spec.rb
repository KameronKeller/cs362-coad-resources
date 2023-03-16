require 'rails_helper'

RSpec.describe 'Creating a Ticket', type: :feature do

    it'As a non-user, create a ticket ' do
        resource_category = create(:resource_category)
        region = create(:region)
        visit root_path
        click_on 'Get Help'
        


        fill_in 'ticket_name', with: 'Content'
        fill_in 'ticket_phone', with: '1-541-456-7890'
        select region.name, from: 'ticket_region_id'
        select resource_category.name, :from => 'ticket_resource_category_id'

        click_on 'Send this help request'
        expect(page).to have_content 'Submitted'


    end

end
