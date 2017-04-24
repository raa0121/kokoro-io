require 'rails_helper'

RSpec.describe BotsController, :type => :controller do
  before do
    login(user)
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BotsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all bots as @bots" do
      bot = Bot.create! valid_attributes
      get :index, pramas: {}, session: valid_session
      expect(assigns(:bots)).to eq([bot])
    end
  end

  describe "GET show" do
    it "assigns the requested bot as @bot" do
      bot = Bot.create! valid_attributes
      get :show, params: {:id => bot.to_param}, session: valid_session
      expect(assigns(:bot)).to eq(bot)
    end
  end

  describe "GET new" do
    it "assigns a new bot as @bot" do
      get :new, params: {}, session: valid_session
      expect(assigns(:bot)).to be_a_new(Bot)
    end
  end

  describe "GET edit" do
    it "assigns the requested bot as @bot" do
      bot = Bot.create! valid_attributes
      get :edit, params: {:id => bot.to_param}, session: valid_session
      expect(assigns(:bot)).to eq(bot)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Bot" do
        expect {
          post :create, params: {:bot => valid_attributes}, session: valid_session
        }.to change(Bot, :count).by(1)
      end

      it "assigns a newly created bot as @bot" do
        post :create, params: {:bot => valid_attributes}, session: valid_session
        expect(assigns(:bot)).to be_a(Bot)
        expect(assigns(:bot)).to be_persisted
      end

      it "redirects to the created bot" do
        post :create, params: {:bot => valid_attributes}, session: valid_session
        expect(response).to redirect_to(Bot.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bot as @bot" do
        post :create, params: {:bot => invalid_attributes}, session: valid_session
        expect(assigns(:bot)).to be_a_new(Bot)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:bot => invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested bot" do
        bot = Bot.create! valid_attributes
        put :update, params: {:id => bot.to_param, :bot => new_attributes}, session: valid_session
        bot.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested bot as @bot" do
        bot = Bot.create! valid_attributes
        put :update, params: {:id => bot.to_param, :bot => valid_attributes}, session: valid_session
        expect(assigns(:bot)).to eq(bot)
      end

      it "redirects to the bot" do
        bot = Bot.create! valid_attributes
        put :update, params: {:id => bot.to_param, :bot => valid_attributes}, session: valid_session
        expect(response).to redirect_to(bot)
      end
    end

    describe "with invalid params" do
      it "assigns the bot as @bot" do
        bot = Bot.create! valid_attributes
        put :update, params: {:id => bot.to_param, :bot => invalid_attributes}, session: valid_session
        expect(assigns(:bot)).to eq(bot)
      end

      it "re-renders the 'edit' template" do
        bot = Bot.create! valid_attributes
        put :update, params: {:id => bot.to_param, :bot => invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested bot" do
      bot = Bot.create! valid_attributes
      expect {
        delete :destroy, params: {:id => bot.to_param}, session: valid_session
      }.to change(Bot, :count).by(-1)
    end

    it "redirects to the bots list" do
      bot = Bot.create! valid_attributes
      delete :destroy, params: {:id => bot.to_param}, session: valid_session
      expect(response).to redirect_to(bots_url)
    end
  end

end
