require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do

    before(:each) do
        create(:user, :admin)
        create(:resource_category)
    end

    it 'can be done with a new user' do
        
        # Login with an unapproved user
        user = create(:user)
        # organization = create(:organization)
        log_in_as(user)

        # Click "Create Application"
        click_on 'Create Application'

        # Choose liability insurance = true
        choose('organization_liability_insurance_true')

        # Check "I agree" on all items 
        choose 'organization_agreement_one_true'
        choose 'organization_agreement_two_true'
        choose 'organization_agreement_three_true'
        choose 'organization_agreement_four_true'
        choose 'organization_agreement_five_true'
        choose 'organization_agreement_six_true'
        choose 'organization_agreement_seven_true'
        choose 'organization_agreement_eight_true'

        # Enter name
        fill_in 'organization_primary_name', with: 'Content'

        # Enter organization name
        fill_in 'organization_name', with: 'Content'

        # enter title
        fill_in 'organization_title', with: 'Content'

        # enter phone number
        fill_in 'organization_phone', with: '111-111-1111'

        # contact
        fill_in 'organization_primary_name', with: 'Content'

        # secondary contact
        fill_in 'organization_secondary_name', with: 'Content'

        # secondary contact phone
        fill_in 'organization_secondary_phone', with: '222-222-2222'

        # organization email
        fill_in 'organization_email', with: 'content@content.com'

        # check a box for donating
        check('organization_resource_category_ids_1')

        # enter a description
        fill_in 'organization_description', with: 'Description'

        # check transportation button
        choose('organization_transportation_yes')
        
        # Click apply
        click_on 'Apply'

        # Expect the "Application Submitted" page to show
        expect(page).to have_content "Application Submitted"
    end

end
