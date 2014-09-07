class AccessTokensController < InheritedResources::Base
  actions :all

  def create
    @access_token = AccessToken.new(permitted_params[:access_token])
    @access_token.token = AccessToken.generate_token
    @access_token.user = current_user
    create!
  end

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
