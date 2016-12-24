require 'json'

module SpecTestHelper
  def login(user)
    request.session[:user_id] = user.id
  end

  def json(response)
    JSON.parse(response)
  end
end

RSpec.configure do |config|
  config.include SpecTestHelper
end
