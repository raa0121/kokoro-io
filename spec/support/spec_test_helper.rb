module SpecTestHelper
  def login(user)
    request.session[:user_id] = user.id
  end
end

RSpec.configure do |config|
  config.include SpecTestHelper, type: :controller
end
