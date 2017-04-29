GrapeSwaggerRails.options.app_name = 'kokoro.io API'

GrapeSwaggerRails.options.url      = '/swagger_doc.json'
GrapeSwaggerRails.options.doc_expansion = 'list'

GrapeSwaggerRails.options.before_action do |request|

  GrapeSwaggerRails.options.app_url = '/api/v1'
  if Rails.env.development? && current_user && current_user.primary_access_token
    GrapeSwaggerRails.options.api_key_default_value = current_user.primary_access_token.token
  else
    GrapeSwaggerRails.options.api_key_default_value = '<Your API token here>'
  end
    GrapeSwaggerRails.options.api_key_name = 'X-Access-Token'
    GrapeSwaggerRails.options.api_key_type = 'header'
end
