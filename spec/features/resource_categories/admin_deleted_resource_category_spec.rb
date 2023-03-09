require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do

    it 'can delete a Resource Category with an admin' do
        admin = create(:user, :admin)
        log_in_as(admin)
        resource_category = create(:resource_category)

        click_on 'Categories'
        click_on resource_category.name
        click_on 'Delete'

        expect(page).to have_content 'Unspecified'

    end

end
