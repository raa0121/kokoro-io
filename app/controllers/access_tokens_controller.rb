class AccessTokensController < ApplicationController
  before_action :set_access_token, only: [:edit, :update, :destroy]

  def index
    @access_tokens = policy_scope(AccessToken)
  end

  def new
    @access_token = AccessToken.new
    authorize @access_token
  end

  def create
    @access_token = AccessToken.new(access_token_params)
    @access_token.token = AccessToken.generate_token
    @access_token.essential = false
    @access_token.user = current_user
    authorize @access_token

    if @access_token.save
      redirect_to access_tokens_path, notice: t('AccessToken was successfully destroyed.')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @access_token.update(access_token_params)
      redirect_to access_tokens_path, notice: t('AccessToken was successfully updated.')
    else
      render :edit
    end
  end

  def destroy
    @access_token.destroy
    redirect_to access_tokens_url, notice: t('AccessToken was successfully destroyed.')
  end

  protected
  def begin_of_association_chain
    current_user
  end

  private
  def access_token_params
    params.require(:access_token).permit(:name)
  end

  def set_access_token
    @access_token = AccessToken.find(params[:id])
    authorize @access_token
  end

end
