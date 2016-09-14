require ::File.expand_path('../../config/environment',  __FILE__)
Rails.application.eager_load!

require 'action_cable/process/logging'

# TODO: make specific, fix for production
# ActionCable.server.config.allowed_request_origins = ['http://rubyonrails.com', /http:\/\/ruby.*/]
ActionCable.server.config.disable_request_forgery_protection = true

run ActionCable.server