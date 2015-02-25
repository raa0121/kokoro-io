class Api::ApplicationController < ActionController::Base
  include Garage::ControllerHelper

  def current_resource_owner
    @current_resource_owner ||= User.where(uid: resource_owner_id).limit(1).first if resource_owner_id
  end

end
