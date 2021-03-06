require 'rails_helper'
RSpec.describe ProfilesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before do
    login(user)
  end

  # This should return the minimal set of attributes required to create a valid
  # Profile. As you add validations to Profile, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProfilesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all profiles as @profiles" do
      profile = Profile.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:profiles)).to eq([profile])
    end
  end

  describe "GET #show" do
    it "assigns the requested profile as @profile" do
      profile = Profile.create! valid_attributes
      get :show, params: {id: profile.to_param}, session: valid_session
      expect(assigns(:profile)).to eq(profile)
    end
  end

  describe "GET #edit" do
    it "assigns the requested profile as @profile" do
      profile = Profile.create! valid_attributes
      get :edit, params: {id: profile.to_param}, session: valid_session
      expect(assigns(:profile)).to eq(profile)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested profile" do
        profile = Profile.create! valid_attributes
        put :update, params: {id: profile.to_param, profile: new_attributes}, session: valid_session
        profile.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested profile as @profile" do
        profile = Profile.create! valid_attributes
        put :update, params: {id: profile.to_param, profile: valid_attributes}, session: valid_session
        expect(assigns(:profile)).to eq(profile)
      end

      it "redirects to the profile" do
        profile = Profile.create! valid_attributes
        put :update, params: {id: profile.to_param, profile: valid_attributes}, session: valid_session
        expect(response).to redirect_to(profile)
      end
    end

    context "with invalid params" do
      it "assigns the profile as @profile" do
        profile = Profile.create! valid_attributes
        put :update, params: {id: profile.to_param, profile: invalid_attributes}, session: valid_session
        expect(assigns(:profile)).to eq(profile)
      end

      it "re-renders the 'edit' template" do
        profile = Profile.create! valid_attributes
        put :update, params: {id: profile.to_param, profile: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested profile" do
      profile = Profile.create! valid_attributes
      expect {
        delete :destroy, params: {id: profile.to_param}, session: valid_session
      }.to change(Profile, :count).by(-1)
    end

    it "redirects to the profiles list" do
      profile = Profile.create! valid_attributes
      delete :destroy, params: {id: profile.to_param}, session: valid_session
      expect(response).to redirect_to(profiles_url)
    end
  end

end
