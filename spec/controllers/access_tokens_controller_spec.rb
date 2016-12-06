require 'rails_helper'
RSpec.describe AccessTokensController, :type => :controller do
  before do
    session[:user_id] = user.id
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) {
    {
      user_id: user.id,
      name: 'hi',
      token: 'token',
      essential: false
    }
  }

  let(:invalid_attributes) {
    {
      user_id: user.id,
      name: '',
      essential: false
    }
  }

  let(:valid_session) {}

  describe "GET index" do
    it "assigns all access_tokens as @access_tokens" do
      access_token = AccessToken.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:access_tokens).size).to eq(2)
    end
  end

  describe "GET new" do
    it "assigns a new access_token as @access_token" do
      get :new, params: {}, session: valid_session
      expect(assigns(:access_token)).to be_a_new(AccessToken)
    end
  end

  describe "GET edit" do
    it "assigns the requested access_token as @access_token" do
      access_token = AccessToken.create! valid_attributes
      get :edit, params: {:id => access_token.to_param}, session: valid_session
      expect(assigns(:access_token)).to eq(access_token)
    end
  end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new AccessToken" do
  #       expect {
  #         post :create, {:access_token => valid_attributes}, session: valid_session
  #       }.to change(AccessToken, :count).by(1)
  #     end
  #
  #     it "assigns a newly created access_token as @access_token" do
  #       post :create, {:access_token => valid_attributes}, session: valid_session
  #       p assigns(:access_token)
  #       expect(assigns(:access_token)).to be_a(AccessToken)
  #       expect(assigns(:access_token)).to be_persisted
  #     end
  #
  #     it "redirects to the created access_token" do
  #       post :create, {:access_token => valid_attributes}, session: valid_session
  #       expect(response).to redirect_to(AccessToken.last)
  #     end
  #   end
  #
  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved access_token as @access_token" do
  #       post :create, {:access_token => invalid_attributes}, session: valid_session
  #       expect(assigns(:access_token)).to be_a_new(AccessToken)
  #     end
  #
  #     it "re-renders the 'new' template" do
  #       post :create, {:access_token => invalid_attributes}, session: valid_session
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {
          name: 'hi2'
        }
      }

      it "updates the requested access_token" do
        access_token = AccessToken.create! valid_attributes
        put :update, params: {:id => access_token.to_param, :access_token => new_attributes}, session: valid_session
        access_token.reload
        expect(assigns(:access_token).name).to eq('hi2')
      end

      it "assigns the requested access_token as @access_token" do
        access_token = AccessToken.create! valid_attributes
        put :update, params: {:id => access_token.to_param, :access_token => valid_attributes}, session: valid_session
        expect(assigns(:access_token)).to eq(access_token)
      end

      it "redirects to the access_token" do
        access_token = AccessToken.create! valid_attributes
        put :update, params: {:id => access_token.to_param, :access_token => valid_attributes}, session: valid_session
        expect(response).to redirect_to(access_tokens_path)
      end
    end

    describe "with invalid params" do
      before do
        AccessToken.create! user: user, name: 'wow', token: 'exist', essential: false
      end
      render_views
      it "assigns the access_token as @access_token" do
        access_token = AccessToken.create! valid_attributes
        put :update, params: {:id => access_token.to_param, :access_token => invalid_attributes}, session: valid_session
        expect(assigns(:access_token)).to eq(access_token)
      end

      it "re-renders the 'edit' template" do
        access_token = AccessToken.create! valid_attributes
        put :update, params: {:id => access_token.to_param, :access_token => invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested access_token" do
      access_token = AccessToken.create! valid_attributes
      expect {
        delete :destroy, params: {:id => access_token.to_param}, session: valid_session
      }.to change(AccessToken, :count).by(-1)
    end

    it "redirects to the access_tokens list" do
      access_token = AccessToken.create! valid_attributes
      delete :destroy, params: {:id => access_token.to_param}, session: valid_session
      expect(response).to redirect_to(access_tokens_url)
    end
  end
end
