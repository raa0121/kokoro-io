module API
  class Root < Grape::API
    format :json
    mount V1::Root
  end
end
