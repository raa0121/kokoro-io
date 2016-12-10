# see: http://www.bokukoko.info/entry/2016/01/01/Grape_on_Rails_%E3%81%A7_API_%E9%96%8B%E7%99%BA
module V1
  class Root < Grape::API
    version 'v1'
    format :json
    prefix :api

    rescue_from :all do |e|
      Root.logger.error(e.message.to-s << '\n' << e.backetrace.join('\n'))
      error!({ message: 'Server Error'}, 500)
    end

    # APIs
    mount V1::Rooms
  end
end
