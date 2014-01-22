require 'sinatra'
require 'json'

#load in our helpers
require 'schema_helper'
require 'poller_helper'
require 'check_helper'
require 'type_helper'

#load our config
require 'config_helper'

module Webrockit
  class Api < Sinatra::Base

    @config = ConfigHelper.hash()
    
    #setup some basic auth
    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      username == @config['application']['basic_auth']['user']
      password == @config['application']['basic_auth']['pass']
    end

    get '/' do
      data = SchemaHelper.showInitial(request)
      if Regexp.new("json") =~ request.accept.to_s
        content_type :json
        data
      else
        erb :html_ui, :locals => {:data => data}
      end
    end

    get '/schemas' do 
      data = SchemaHelper.showSchemas(request)
      if Regexp.new("json") =~ request.accept.to_s
        content_type :json
        data
      else
        erb :html_ui, :locals => {:data => data}
      end
    end

    ##Checks
    #check
    get '/v1/createCheck' do
      error = 'none'
      check_types = TypeHelper.list
      required_params = ['name','url','type','application','interval']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  

      # need to make sure the check type is in our supported list..
      ## check types outside this list may not get picked up by the sync application 
      unless check_types.include?(params['type'])
        error = "Please choose a valid check_type (#{check_types})"
      end

      create_hash = {
        'name'        => params['name'],
        'url'         => params['url'],
        'type'        => params['type'],
        'application' => params['application'],
        'poller'      => params['poller'],
        'interval'    => params['interval'],
        'ipaddress'   => params['ipaddress']

      }

      if error == 'none'
        data = CheckHelper.create(create_hash)
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        {'status' => 'error', 'message' => error}.to_json
      end

    end

    #list checks by type
    get '/v1/listChecks' do
      error = 'none'
      required_params = ['type']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  
      if error == 'none'
        data = CheckHelper.listChecksByType(params['type'])
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        {'status' => 'error', 'message' => error}.to_json
      end
    end

    #fetch check info
    get '/v1/fetchCheck' do
      error = 'none'
      required_params = ['type','name']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  
      if error == 'none'
        data = CheckHelper.fetch(params['name'],params['type'])
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        {'status' => 'error', 'message' => error}.to_json
      end
    end

    get '/v1/deleteCheck' do
      error = 'none'
      required_params = ['type','name']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  

      if error == 'none'
        data = CheckHelper.delete(params['name'],params['type'])
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        {'status' => 'error', 'message' => error}.to_json
      end
    end

    ## Types
    #create type
    get '/v1/createType' do
      error = 'none'
      required_params = ['type','description']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  

      if error == 'none'
        data = TypeHelper.create(params['type'],params['description'])
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        {'status' => 'error', 'message' => error}.to_json
      end
    end

    #delete type
    get '/v1/deleteType' do
      error = 'none'
      required_params = ['type']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  

      if error == 'none'
        data = TypeHelper.delete(params['type'])
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        {'status' => 'error', 'message' => error}.to_json
      end
    end

    #list check types
    get '/v1/listTypes' do
      data = TypeHelper.list
      if Regexp.new("json") =~ request.accept.to_s
        content_type :json
        data
      else
        erb :html_ui, :locals => {:data => data}
      end
    end

    #fetch the type data/desc
    get '/v1/fetchType' do
      error = 'none'
      required_params = ['type']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  

      if error == 'none'
        data = TypeHelper.fetch(params['type'])
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        {'status' => 'error', 'message' => error}.to_json
      end
    end

    ##Pollers
    #create poller
    get '/v1/createPoller' do
      error = 'none'
      required_params = ['poller','description']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  

      if error == 'none'
        data = PollerHelper.create(params['poller'],params['description'])
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        {'status' => 'error', 'message' => error}.to_json
      end
    end

    #delete poller
    get '/v1/deletePoller' do
      error = 'none'
      required_params = ['poller']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  

      if error == 'none'
        data = PollerHelper.delete(params['poller'])
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        {'status' => 'error', 'message' => error}.to_json
      end
    end

    #list check pollers
    get '/v1/listPollers' do
      data = PollerHelper.list
      if Regexp.new("json") =~ request.accept.to_s
        content_type :json
        data
      else
        erb :html_ui, :locals => {:data => data}
      end
    end

    #fetch the poller data/desc
    get '/v1/fetchPoller' do
      error = 'none'
      required_params = ['poller']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  

      if error == 'none'
        data = PollerHelper.fetch(params['poller'])
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        {'status' => 'error', 'message' => error}.to_json
      end
    end
  end
end
