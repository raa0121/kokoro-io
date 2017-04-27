require 'refile/simple_form'
require 'refile/s3'

if Rails.env.production?
  aws = {
    access_key_id: Rails.application.secrets.s3_access_key_id,
    secret_access_key: Rails.application.secrets.s3_secret_access_key,
    region: Rails.application.secrets.s3_region,
    bucket: Rails.application.secrets.s3_bucket,
  }

  Refile.cdn_host = Rails.application.secrets.cdn_host
  Refile.configure do |config|
    config.cache = Refile::S3.new(prefix: 'cache', **aws)
    config.store = Refile::S3.new(prefix: 'store', **aws)
  end
end
