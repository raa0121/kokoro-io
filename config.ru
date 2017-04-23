# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
use Rack::ETag
use Rack::Deflater
use Rack::Static, urls: ['/stylesheets', '/javascripts', '/fonts'],
                  root: 'assets/dist',
                  header_rules: [
                    [:all, {
                      'Cache-Control' => 'max-age=0'
                    }]
                  ]
run Rails.application
