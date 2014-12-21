class V1::AccessTokensController < V1::ApplicationController
  include Garage::RestfulActions

  def require_resources
    @resources = AccessToken.all
  end

  #def create
  #  @access_token = AccessToken.new(permitted_params[:access_token])
  #  @access_token.token = AccessToken.generate_token
  #  @access_token.essential = false
  #  @access_token.user = current_user
  #  create! do |success, failure|
  #    success.html { redirect_to access_tokens_path }
  #  end
  #end

  #def update
  #  super do |success, failure|
  #    success.html { redirect_to access_tokens_path }
  #  end
  #end

  protected
  def begin_of_association_chain
    current_user
  end

  private
  def permitted_params
    params.permit(access_token: [:name])
    # params.require(:access_token).permit(:name)
  end

end
