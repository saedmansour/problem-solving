require File.expand_path('../boot', __FILE__)

require 'rails/all'

require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Wokami
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.enabled = true

    #if Rails.env.production?
      
      #   Note:
      #     there's few problems with letting all css and js be compiled, with rails admin? I don't 
      #     remember but assets prcompile isn't a simple thing.
      #     read asset pipeleine to understand more
      #
      
      config.assets.precompile += ['rails_admin/rails_admin.css', 'rails_admin/rails_admin.js']
      config.assets.precompile += ['knockout.js']
      config.assets.precompile += ['application.scss.erb']
      #config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.woff *.otf *.svg *.ttf *.css *.js)
      config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.woff *.otf *.svg *.ttf *.css)
      #config.assets.precompile += ['saedmansour.woff']
      #config.assets.precompile += %w( *.css *.js )
      config.assets.precompile << Proc.new do |path|
        #if path =~ /\.(css|js|jpg|woff|otf|svg|ttf)\z/
        if path =~ /\.(jpg|woff|otf|svg|ttf)\z/
          full_path = Rails.application.assets.resolve(path).to_path
          app_assets_path = Rails.root.join('app', 'assets').to_path
          if full_path.starts_with? app_assets_path
            puts "including asset: " + full_path
            true
          else
            puts "excluding asset: " + full_path
            false
          end
        else
          false
        end
      end
    #end

    config.to_prepare do
      Devise::SessionsController.skip_before_filter :require_login
      Devise::RegistrationsController.skip_before_filter :require_login
      Users::OmniauthCallbacksController.skip_before_filter :require_login
    end

    
  end
end
