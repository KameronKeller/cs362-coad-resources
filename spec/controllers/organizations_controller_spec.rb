require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

    # LOGGED IN
    context 'as a logged-in approved user' do
        let(:user) { create(:user, :organization_approved ) }
        before(:each) { sign_in(user) }
        #use trait in user factory

        describe "GET #index" do
          it { expect(get(:index)).to be_successful }
        end
  
        describe "GET #new" do
          it { expect(get(:new)).to redirect_to(dashboard_path) } 
        end
  
        describe "POST #create" do #can a existing user make a organization?
            it { expect(post(:create)).to redirect_to(dashboard_path) }
        end
        #    it {
        #     post(:create, params: { organization: attributes_for(:organization) })
        #     expect(response).to be_successful
        #   }

        describe "PATCH #update" do #is this correct?

          let(:organization) { create(:organization) }
          it { expect(patch(:update, params: { id: organization.id, organization: {name:"updated" } })).to redirect_to(organization_path) }

          it {
            expect_any_instance_of(Organization).to receive(:update).and_return(false)
            expect(patch(:update, params: { id: organization.id, organization: {name:"updated" } })).to be_successful
          }
        
        end

        describe "POST #approve" do
          let(:organization) { build(:organization) } 
          it { expect(post(:approve, params: { id: organization.id })).to redirect_to(dashboard_path) }
        end

        describe "POST #reject" do
          let(:organization) { build(:organization) } 
          it { expect(post(:reject, params: { id: organization.id })).to redirect_to(dashboard_path) }
        end


    end

    context 'as a logged-in unapproved user' do
        let(:user) { create(:user, :organization_unapproved) }
        let(:admin) { create(:user, :admin )}
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end

        describe "GET #new" do
            it { expect(get(:new)).to be_successful }
        end

        describe "POST #create" do
            let(:organization) { create(:organization) }
            it {
                user = create(:user, :admin)
                post(:create, params: { organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_application_submitted_path) 
            }

            it { 
                expect_any_instance_of(Organization).to receive(:save).and_return(false)
                expect(post(:create, params: { organization: attributes_for(:organization)}))
                expect(response).to be_successful
            }

        #             it {
        #   expect_any_instance_of(Region).to receive(:save).and_return(false)
        #   post(:create, params: { region: attributes_for(:region) })
        #   expect(response).to be_successful 
        # }
        end

        describe "POST #approve" do
          let(:organization) { build(:organization) } 
          it { expect(post(:approve, params: { id: organization.id })).to redirect_to(dashboard_path) }
        end

        describe "POST #reject" do
          let(:organization) { build(:organization) } 
          it { expect(post(:reject, params: { id: organization.id })).to redirect_to(dashboard_path) }
        end

    end




    # LOGGED OUT
    context 'as a logged-out user' do
        let(:user) { create(:user) }

        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(new_user_session_path) }
        end

        describe "GET #new" do
            it { expect(get(:new)).to redirect_to(new_user_session_path)}
        end

        describe "POST #create" do
            it { expect(post(:create)).to redirect_to(new_user_session_path) }
        end

        describe "POST #approve" do
          let(:organization) { build(:organization) } 
          it { expect(post(:approve, params: { id: organization.id })).to redirect_to(new_user_session_path) }
        end

        describe "POST #reject" do
          let(:organization) { build(:organization) } 
          it { expect(post(:reject, params: { id: organization.id })).to redirect_to(new_user_session_path) }
        end


    end

    # ADMIN
    context 'as an admin user' do
        let(:user) { create(:user, :admin) }
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful } #what about checking in order?
        end
        
        describe "GET #new" do
            it { expect(get(:new)).to redirect_to(dashboard_path) }
        end

        describe "POST #create" do #can a existing user make a organization?
            it { expect(post(:create)).to redirect_to(dashboard_path) }
        end

        describe "POST #approve" do
            let(:organization) { create(:organization) }
            it { expect(post(:approve,  params: { id: organization.id })).to redirect_to(organizations_path) }

            it {
                expect_any_instance_of(Organization).to receive(:save).and_return(false)
                expect(post(:approve, params: { id: organization.id }))
                expect(response).to be_successful
            }
        end

        describe "POST #reject" do
            let(:organization) { create(:organization) }
            it { 
                organization.rejection_reason = "rejected"
                expect(post(:reject, params: { id: organization.id, organization: {rejection_reason: "rejected" } })).to redirect_to(organizations_path)
            } 

            it {
                expect_any_instance_of(Organization).to receive(:save).and_return(false)
                expect(post(:approve, params: { id: organization.id }))
                expect(response).to be_successful
            }
            
        end

        # describe "POST #approve" do
        #   let(:organization) { create(:organization) } 
        #   it { expect(get(:approve, params: { id: organization.id })).to redirect_to(organizations_path) }
          
        #   it {  #why is this returning false instead of true, when regions does the same thing?
        #     expect_any_instance_of(Organization).to receive(:approve).and_return(false)
        #     expect(get(:approve, params: { id: organization.id })).to be_successful 
        #   }
        # end


        # #rejection_reason:"stuff" ?
        # describe "POST #reject" do
        #   let(:organization) { create(:organization, :org_rejected) } 
        #   it { expect(post(:reject, params: { id: organization.id})).to redirect_to(organizations_path) }

        #   it { 
        #     expect_any_instance_of(Organization).to receive(:reject).and_return(false)
        #     expect(get(:reject, params: { id: organization.id })).to be_successful
        #   }
        # end

    end


end
