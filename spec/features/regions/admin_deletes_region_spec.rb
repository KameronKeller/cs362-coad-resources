require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do

    it 'can delete a region with an admin' do
        admin = create(:user, :admin)
        log_in_as(admin)
        region = create(:region)

        click_on 'Regions'
        click_on region.name
        click_on 'Delete'

        expect(page).to have_content 'Unspecified'

    end

end
