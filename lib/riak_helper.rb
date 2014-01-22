require 'riak'
require 'json'
require 'config_helper'

module RiakHelper
  @config = ConfigHelper.hash()

  def self.add(bucketname,key,indexes,jsondoc)
    begin
      client = Riak::Client.new(:host => @config['datasource']['riak']['host'], 
                                :protocol => "pbc", 
                                :pb_port => @config['datasource']['riak']['pb_port'])
      bucket = client.bucket(bucketname)
      object = bucket.get_or_new(key)
      object.content_type = "application/json"
      object.data = jsondoc.to_json
      object.store

      #set our index
      object.indexes["#{bucketname}_bin"] = indexes
      object.store
      return {:status => "ok"}.to_json
    rescue => e
      return {:status => "error", :message => e}.to_json
    end
  end

  def self.fetch(bucketname,key)
    begin
      client = Riak::Client.new(:host => @config['datasource']['riak']['host'], 
                                :protocol => "pbc", 
                                :pb_port => @config['datasource']['riak']['pb_port'])
      bucket = client.bucket(bucketname)
      object = bucket.get_or_new(key)
      return {:status => "ok", :data => JSON.parse(object.data) }.to_json
    rescue => e
      return {:status => "error", :message => e}.to_json
    end
  end

  def self.delete(bucketname,key)
    begin
      client = Riak::Client.new(:host => @config['datasource']['riak']['host'], 
                                :protocol => "pbc", 
                                :pb_port => @config['datasource']['riak']['pb_port'])
      bucket = client.bucket(bucketname)
      object = bucket.get(key)
      object.delete
      return {:status => "ok"}.to_json
    rescue => e
      return {:status => "error", :message => e}.to_json
    end
  end

  def self.listKeysFromIndex(bucketname,indexname)
    begin
      client = Riak::Client.new(:host => @config['datasource']['riak']['host'], 
                                :protocol => "pbc", 
                                :pb_port => @config['datasource']['riak']['pb_port'])
      bucket = client.bucket(bucketname)
      
      # setting a max, we can bump this up later and add pagination
      keys = bucket.get_index "#{bucketname}_bin", "#{indexname}", max_results: 3000
      return {:status => "ok",:data => keys}.to_json
    rescue => e
      return {:status => "error", :message => e}.to_json
    end
  end
end