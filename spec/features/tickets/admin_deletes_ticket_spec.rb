require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do

    it 'can delete a ticket with an admin' do
        ticket = create(:ticket)
        admin = create(:user, :admin)
        log_in_as(admin)

        click_on ticket.name
        click_on 'Delete'
        
        expect(page).to_not have_content ticket.name

    end

end
