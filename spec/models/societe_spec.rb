require 'rails_helper'

describe User do
    describe "associations utilisateurs et sociétés" do
        before(:each) do
            #@societe = Societe.create!(@attr)
            @societe = FactoryGirl.create(:societe)
            @user = FactoryGirl.create(:user, :societe => @societe)
        end

        it "devrait répondre aux associations" do
            expect(@societe).to respond_to(:users)
            expect(@user).to respond_to(:societe)
        end
    end

end
