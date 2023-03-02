require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

    #NON-USER:
    context 'As a logged-out user' do
        
        describe "GET #index" do
            it { expect(get(:new)).to be_successful }
        end

        describe "POST #create" do
            let (:ticket) { create(:ticket) }
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            it{
                a = attributes_for(:ticket)
                a[:region_id] = region.id
                a[:resource_category_id] = resource_category.id

                post(:create, params: {ticket: a }) #returns 200ok
                expect(response).to redirect_to(ticket_submitted_path)
            }

            it {
                expect_any_instance_of(Ticket).to receive(:save).and_return(false)
                post(:create, params: { ticket: attributes_for(:ticket) })
                expect(response).to be_successful 
            }

        end


    end

   # Logged-in approved user
    context 'as a approved user' do
        let(:user) { create(:user, :organization_approved) }
        before(:each) { sign_in(user) }

        describe "GET #show" do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id) }

            it { expect(get(:show, params: { id: ticket.id } )).to be_successful }
        end 

        describe "POST #capture" do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id) }

            it{
                expect(post(:capture, params: { id: ticket.id } )).to redirect_to(dashboard_path << '#tickets:open')}
            it{
                expect(TicketService).to receive(:capture_ticket).and_return(false)
                expect(post(:capture, params: { id: ticket.id } )).to be_successful }
        end

        describe "POST #release" do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id) }

            it{
                expect(post(:release, params: { id: ticket.id } )).to redirect_to(dashboard_path << '#tickets:organization')}
            it{
                expect(TicketService).to receive(:release_ticket).and_return(false)
                expect(post(:release, params: { id: ticket.id } )).to be_successful }

        end

    end



    #ADMIN:
    context 'as a admin user' do
        let(:user) { create(:user, :admin) }
        before(:each) { sign_in(user) }


        describe "GET #show" do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id) }

            it { expect(get(:show, params: { id: ticket.id } )).to be_successful }

            it{

            }
        end 

        describe "POST #release" do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id) }

            it{
                expect(post(:release, params: { id: ticket.id } )).to redirect_to(redirect_to dashboard_path << '#tickets:captured')
            }

            it{
                expect(TicketService).to receive(:release_ticket).and_return(false)
                expect(post(:release, params: { id: ticket.id } )).to be_successful 
            }

        end

        
        describe 'DELETE#destroy' do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region)}
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id) }
            it { 
                expect(delete(:destroy, params: { id: ticket.id })).to redirect_to(dashboard_path << '#tickets') 
            }
                #expect(response).to redirect_to(regions_path) 
        end

    end

end
