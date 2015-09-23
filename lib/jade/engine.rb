require 'sprockets'
require 'sprockets/engines'

module Jade
  class Engine < Rails::Engine
    initializer "jade.configure_rails_initialization", :before => 'sprockets.environment', :group => :all do |app|
      sprockets = app.assets || Sprockets
      sprockets.register_engine '.jade', ::Jade::Template
    end
  end
end
