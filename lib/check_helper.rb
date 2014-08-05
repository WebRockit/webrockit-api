require 'riak'
require 'json'
require 'config_helper'

module CheckHelper
  def self.create(create_hash)
    @config = ConfigHelper.hash()
    bucketname = "webrockitchecks"
    sensutags = ['webrockit','webrockit-api']

    #default poller name here.
    default_pollers = ["#{@config['application']['default_poller_name']}"]
    key = "#{create_hash['type']}::#{create_hash['name']}"
    indexes = [create_hash['application'], create_hash['type'], create_hash['poller'], 'check']

    # Allows us to set an ip address in case there is no DNS setup for the url
    command = 'broken'
    if create_hash['ipaddress'].nil?
      command = "#{@config['application']['check_runner']} --url #{create_hash['url']}"
    else
      if create_hash['ipaddress'] == 'none'
        command = "#{@config['application']['check_runner']} --url #{create_hash['url']}"
      else
        command = "#{@config['application']['check_runner']} --url #{create_hash['url']} --ip #{create_hash['ipaddress']}"
      end
    end
    puts create_hash['ipaddress']

    # we want to set the poller location to a specific subscriber if applied
    pollers = ["#{create_hash['poller']}"]
    pollers = default_pollers if create_hash['poller'].nil?

    # build the json object that gets dumped into riak
    checkjs = {
      'checks' => {
        create_hash['name'] => {
          'type'     => 'metric',
          'handlers' => ["#{@config['application']['metrics_handler_name']}"],
          'command'  => command,
          'interval' => create_hash['interval'].to_i,
          'subscribers' => pollers | sensutags
        }
      }
    }

    return RiakHelper.add(bucketname,key,indexes,checkjs)
  end

  def self.delete(name,type)
    key = "#{type}::#{name}"
    return RiakHelper.delete('webrockitchecks',key)
  end

  def self.listChecksByType(type)
    return RiakHelper.listKeysFromIndex('webrockitchecks',type)
  end

  def self.fetch(name,type)
    key = "#{type}::#{name}"
    return RiakHelper.fetch('webrockitchecks',key)
  end

end
