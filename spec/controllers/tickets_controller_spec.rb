require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

    #NON-USER:
    context 'As a logged-out user' do
        
        describe "GET #index" do
            it { expect(get(:new)).to be_successful }
        end

    #     #  def create
    # @ticket = Ticket.new(
    #     name: params[:ticket][:name],
    #     phone: format_phone_number(params[:ticket][:phone]),
    #     description: params[:ticket][:description],
    #     region_id: params[:ticket][:region_id],
    #     resource_category_id: params[:ticket][:resource_category_id]
    #   )
    #   if @ticket.save
    #     redirect_to ticket_submitted_path
    #   else
    #     render :new
    #   end
    # end


    # describe "POST #create" do  
    # it {
    #   post(:create, params: { region: attributes_for(:region) })
    #   expect(response).to redirect_to(regions_path) 
    # }

    # it {
    #   expect_any_instance_of(Region).to receive(:save).and_return(false)
    #   post(:create, params: { region: attributes_for(:region) })
    #   expect(response).to be_successful 
    # }
  #end

#   name: params[:ticket][:name],
#   phone: format_phone_number(params[:ticket][:phone]),
#   description: params[:ticket][:description],
#   region_id: params[:ticket][:region_id],
#   resource_category_id: params[:ticket][:resource_category_id]

        describe "POST #create" do
            let (:ticket) { create(:ticket) }
            let(:resource_category) {create(:resource_category)}
            let(:region) {create(:region) }
            it{
                post(:create, params: {ticket: attributes_for(:ticket) })
                # post(:create, params: {name: "ticket", phone: "123-456-7890", })
                expect(response).to redirect_to(ticket_submitted_path)
            }

            it{
                expect_any_instance_of(Ticket).to receive(:save).and_return(false)
                post(:create, params: { ticket: attributes_for(:ticket) })
                expect(response).to be_successful 
            }

        end


    end

    #Logged-in user
    context 'as a approved user' do
        let(:user) { create(:user) }
        before(:each) { sign_in(user) }
    end

    #ADMIN:
    context 'as a admin user' do
        let(:user) { create(:user, :admin) }
        before(:each) { sign_in(user) }

        
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
