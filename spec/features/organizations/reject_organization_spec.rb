require 'rails_helper'

RSpec.describe 'Rejecting an organization', type: :feature do


    it 'can be done from the dashboard' do
    #log in as admin
    user = create(:user, :admin)
    organization = create(:organization)
    log_in_as(user)

    #navigate to the pending orgs
    visit dashboard_path 
    click_on 'Organizations'
    click_on 'Pending'

    # save_and_open_page()
    click_on 'Review'
    click_on 'Reject'

    expect(organization.reload.rejected?).to be true

    end

    it 'cannot be done by a no-admin user' do
        organization = create(:organization, :approved)
        user = create(:user, organization: organization)
        not_approved_organization = create(:organization)

        log_in_as(user)

        visit dashboard_path

        expect(current_path).to_not have_content 'Organization Applications'

        visit organization_path(id: not_approved_organization.id) # visit the path to a specific organization
        expect(page).not_to have_content 'Reject'
    end



end
