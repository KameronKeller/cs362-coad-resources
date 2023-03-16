require 'rails_helper'

RSpec.describe 'Approving an organization', type: :feature do

    it 'can be done from the dashboard' do
        user = create(:user, :admin)
        organization = create(:organization)
        log_in_as(user)

        visit dashboard_path #navigate to the dashboard

        click_on 'Organizations'
        click_on 'Pending'
        click_on 'Review'
        click_on 'Approve'

        expect(organization.reload.approved?).to be true

    end
    
    it 'cannot be done by a no-admin user' do
        organization = create(:organization, :approved)
        user = create(:user, organization: organization)
        not_approved_organization = create(:organization)

        log_in_as(user)

        visit dashboard_path

        expect(current_path).to_not have_content 'Organization Applications'

        visit organization_path(id: not_approved_organization.id) # visit the path to a specific organization
        expect(page).not_to have_content 'Approve'
    end

end
