require 'grape-swagger'

module V1
  class Root < Grape::API
    version 'v1'
    format :json
    prefix :api

    # Exceptions
    rescue_from ActiveRecord::RecordNotFound do |e|
      error!({message: 'Record not found.'}, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      # NOTE: Is this status code appropriate?
      error!({message: 'Record invalid.' }, 404)
    end

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
