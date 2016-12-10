module V1
  class Root < Grape::API
    version 'v1'
    format :json
    prefix :api

    # APIs
    mount V1::Rooms
  end
end
