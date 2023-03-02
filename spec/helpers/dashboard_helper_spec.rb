require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end


RSpec.describe DashboardHelper, type: :helper do
    #use a factory, traits in factory

    # describe "admin user" do
    #     #create admin user

    #     it ""

    context "admin" do
        # let(:user) { build(:user, :admin?: true) } # one way to do this
        let(:user) { instance_double('User', admin?: true) }
        
        describe "gets the admin dashboard" do
            it { expect(helper.dashboard_for(user)).to eq 'admin_dashboard' }
        end
    end

    context "organization approved" do
        # let(:user) { build(:user, :organization_approved) } # one way to do this
        let(:user) { instance_double('User', admin?: false, organization: Organization.new(status: :approved)) }

        describe "gets the organization_approved_dashboard dashboard" do
            it { expect(helper.dashboard_for(user)).to eq 'organization_approved_dashboard' }
        end
    end

    context "organization submitted" do
        # let(:user) { build(:user, :organization_approved) } # one way to do this
        let(:user) { instance_double('User', admin?: false, organization: Organization.new(status: :submitted)) }

        describe "gets the organization_submitted_dashboard dashboard" do
            it { expect(helper.dashboard_for(user)).to eq 'organization_submitted_dashboard' }
        end
    end

    context "organization locked" do
        # let(:user) { build(:user, :organization_approved) } # one way to do this
        let(:user) { instance_double('User', admin?: false, organization: Organization.new(status: :locked)) }

        describe "gets the create_application_dashboard dashboard" do
            it { expect(helper.dashboard_for(user)).to eq 'create_application_dashboard' }
        end
    end

    context "organization rejected" do
        # let(:user) { build(:user, :organization_approved) } # one way to do this
        let(:user) { instance_double('User', admin?: false, organization: Organization.new(status: :rejected)) }

        describe "gets the create_application_dashboard dashboard" do
            it { expect(helper.dashboard_for(user)).to eq 'create_application_dashboard' }
        end
    end




end
