require 'bundler/setup'

require 'action_controller/railtie'
require 'singed'
require 'singed/railtie'
require 'logger'

Rails.logger = Logger.new(STDOUT)

class App < ::Rails::Application
  routes.append do
    root to: 'root#index'
  end

  config.eager_load = false
end

class RootController < ActionController::Base
  def index
    hello
    sleep 2
    render plain: Rails.version
  end

  private
  def hello
    sleep 1
  end
end

App.initialize!


run App
# curl -H 'X-Singed: true' https://localhost:8080

