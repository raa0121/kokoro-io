require 'json'

module SpecTestHelper
  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  def json(response)
    JSON.parse(response)
  end
end

RSpec.configure do |config|
  config.include SpecTestHelper
end
