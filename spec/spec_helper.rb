require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'webrockit-api')

require 'rack/test'
require 'rspec'


#make Rack::Text available to all spec contexts
RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.order_groups_and_examples do |list|
    list.sort_by { |item| item.description }
  end
end

#specify that the app is a Sinatra app
def app
  Webrockit::Api
end

#get rid of deprecated warnings
I18n.enforce_available_locales = true
