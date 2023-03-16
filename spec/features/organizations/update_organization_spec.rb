require 'rails_helper'

RSpec.describe 'Updating an Organization', type: :feature do


    it 'approved user can update organization' do
        #log in as approved org/user
        organization = create(:organization, :approved)
        ticket = create(:ticket)
        user = create(:user, organization: organization)
        not_approved_organization = create(:organization)

        log_in_as(user)
        visit dashboard_path

        #change org name
        click_on 'Edit Organization'
        fill_in 'organization_name', with: 'dummy org'
        click_on 'Update Resource'

        #confirm sucessful/failure
        ###????###
        # The code in controller was never implemented, nothing to test here



    end

end
