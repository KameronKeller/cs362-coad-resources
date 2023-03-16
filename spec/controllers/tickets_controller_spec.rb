require 'rails_helper'

RSpec.describe TicketsController, type: :controller do


    #NON-USER:
    context 'As a logged-out user' do

        ## in-class ###
        describe 'post #release' do
            it {
                ticket = create(:ticket)
                post(:release, params: { id: ticket.id})
                expect(response).to redirect_to dashboard_path
            }
        end
        
        describe "GET #index" do
            it { expect(get(:new)).to be_successful }
        end

        #region name error
        describe "POST #create" do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            let (:ticket) { create(:ticket) }
            it{
                a = attributes_for(:ticket)
                a[:region_id] = region.id
                a[:resource_category_id] = resource_category.id

                post(:create, params: {ticket: a })
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

        # In class
            describe 'post #release do own the ticket' do
                it {
                    ticket = create(:ticket, organization_id: user.organization_id)
                    post(:release, params: { id: ticket.id })
                    expect(response).to redirect_to (dashboard_path << '#tickets:organization')
                }
            end

            # In class
            describe 'post #release don\'t own the ticket' do
                it {
                    org2 = create(:organization)
                    ticket = create(:ticket, organization_id: org2.id)
                    post(:release, params: { id: ticket.id })
                    expect(response).to be_successful
                }
            end


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
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id, organization_id: user.organization_id) }

            it{
                expect(post(:release, params: { id: ticket.id } )).to redirect_to(dashboard_path << '#tickets:organization')}
            it{
                expect(TicketService).to receive(:release_ticket).and_return(false)
                expect(post(:release, params: { id: ticket.id } )).to be_successful }

        end

        describe "PATCH #close" do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id, organization_id: user.organization_id) }

            it{
                expect(patch(:close, params: { id: ticket.id } )).to redirect_to(dashboard_path << '#tickets:organization')}
            it{
                expect(TicketService).to receive(:close_ticket).and_return(false)
                expect(patch(:close, params: { id: ticket.id } )).to be_successful }
        
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

        # in-class
        describe 'post #release' do
            it {
                user = create(:user, :admin)
                ticket = create(:ticket)
                post(:release, params: { id: ticket.id})
                expect(response).to redirect_to dashboard_path
            }
        end

        # in class
        describe 'post #release don\'t own the ticket' do
            it {
                user = create(:user, :organization_approved, :admin)
                sign_in user
                ticket = create(:ticket, organization_id: user.organization_id)
                post(:release, params: { id: ticket.id })
                expect(response).to redirect_to (dashboard_path << '#tickets:captured')
            }
        end



        describe "POST #release" do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id) }

            it{
                expect(post(:release, params: { id: ticket.id } )).to redirect_to(dashboard_path)} #can't redirect to captured, no tickets belong to admins


        end

        
        describe 'DELETE#destroy' do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region)}
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id) }
            it { 
                expect(delete(:destroy, params: { id: ticket.id })).to redirect_to(dashboard_path << '#tickets') 
            }
        end

        describe "PATCH #close" do
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            let(:ticket) { create(:ticket, region_id: region.id, resource_category_id: resource_category.id) }

            it{
                expect(patch(:close, params: { id: ticket.id } )).to redirect_to(dashboard_path << '#tickets:open')}
            it{
                expect(TicketService).to receive(:close_ticket).and_return(false)
                expect(patch(:close, params: { id: ticket.id } )).to be_successful }
        
        end

    end

end
