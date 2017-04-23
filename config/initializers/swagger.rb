GrapeSwaggerRails.options.app_name = 'kokoro.io API'

GrapeSwaggerRails.options.url      = '/swagger_doc.json'
GrapeSwaggerRails.options.doc_expansion = 'list'

GrapeSwaggerRails.options.before_action do |request|
  current_user = User.find_by(id: session[:user_id])

  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port + '/api/v1'
  if Rails.env.development? && current_user && current_user.primary_access_token
    GrapeSwaggerRails.options.api_key_default_value = current_user.primary_access_token.token
  else
    GrapeSwaggerRails.options.api_key_default_value = '<Your API token here>'
  end
    GrapeSwaggerRails.options.api_key_name = 'X-Access-Token'
    GrapeSwaggerRails.options.api_key_type = 'header'
end
