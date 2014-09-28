FactoryGirl.define do

  factory :access_token do
    user
    sequence(:name) {|n| "Token #{n}" }
    essential false
    token { AccessToken.generate_token }
  end

end
