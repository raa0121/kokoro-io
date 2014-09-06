class AccessTokensController < InheritedResources::Base
  private
  def permitted_params
    params.permit(access_token: [:user_id, :name, :token])
  end
end
