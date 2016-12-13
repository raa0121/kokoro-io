require 'grape-swagger'

module V1
  class Root < Grape::API
    version 'v1'
    format :json
    prefix :api

    # API
    mount V1::Rooms

    # API document
    add_swagger_documentation(
      api_version: 'v1',
      base_path: "#{ENV['API_BASE_PATH']}",
      hide_documention_path: true,
      info: {
        title: 'kokoro.io API document',
      },
      doc_version: '1.0.0',
      mount_path: '/documentation'
    )
  end
end
