require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

    # In-class test implementation

    context 'as a logged-in user' do
      let(:user) { create(:user) }
      before(:each) { sign_in(user) }

      describe "GET #index" do
        it { expect(get(:index)).to redirect_to(dashboard_path) }
      end

      describe "GET #show" do
        let(:region) { create(:region) }
        it { expect(get(:show, params: { id: region.id } )).to redirect_to(dashboard_path) }
      end

      describe "POST #create" do
         it {
          post(:create, params: { region: attributes_for(:region) })
          expect(response).to redirect_to(dashboard_path)
        }
      end
    end


    context 'as a logged-out user' do
      let(:user) { create(:user) }
      
      describe "GET #index" do
        it { expect(get(:index)).to redirect_to(new_user_session_path) }
      end

      describe "GET #show" do
        let(:region) { create(:region) }
        it { expect(get(:show, params: { id: region.id } )).to redirect_to(new_user_session_path) }
      end

      describe "POST #create" do
        it {
         post(:create, params: { region: attributes_for(:region) })
         expect(response).to redirect_to(new_user_session_path)
       }
     end
    end


    context 'as a admin user' do
      let(:user) { create(:user, :admin) }
      before(:each) { sign_in(user) }
      describe "GET #index" do
        it { expect(get(:index)).to be_successful }
      end

      describe "GET #show" do
        let(:region) { create(:region) }
        it { expect(get(:show, params: { id: region.id } )).to be_successful }
      end 

      describe "POST #create" do
        # let(:region) { create(:region) }
        #can't have region of the same name, creating one here and in the post request

        it {
          # post(:create, params: { region: { :name => region.name } })
          
          # expect(response).to be_successful
          # ^ this works by itself

          post(:create, params: { region: attributes_for(:region) })
          expect(response).to redirect_to(regions_path)
        }
      end
    end


    #params is hash, all data passed to this function
    #want tickets, find ID

    
    
 


    #Redirects to dashboard path found in application controller
    #actually redirects to signin page

    
    # it "returns all regions" do
    #     region_controller = RegionsController.new
    #     puts "printing here:"
    #     puts region_controller.index.length()
    # end
        # describe "GET index" do

        #   it "contains the regions" do
        #     region = Region.create
        #     get "index"
        #     # region.name = "ASDF"
        #     expect(response).to include region
        #   end

        # end

end


#     describe "get stuff" do

#         it "shows regions when user is admin" do

#         end

#         it "shows regions when user is user" do

#         end

#         it "does not show regions when not a user" do
        
#         end


            

# end


# RSpec.describe TeamsController do
#     describe "GET index" do
#       it "assigns @teams" do
#         team = Team.create
#         get :index
#         expect(assigns(:teams)).to eq([team])
#       end
  
#       it "renders the index template" do
#         get :index
#         expect(response).to render_template("index")
#       end
#     end
#   end
