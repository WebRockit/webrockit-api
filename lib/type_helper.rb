require 'riak_helper'
module TypeHelper
  def self.create(type,description)
    key = type
    indexes = ['type',type]
    jsondoc = {
      'name' => type,
      'description' => description
    }
    return RiakHelper.add('webrockittypes',key,indexes,jsondoc)
  end

  def self.delete(type)
    checks = JSON.parse(RiakHelper.listKeysFromIndex('webrockitchecks',type))
    if checks['data'].empty?
      return RiakHelper.delete('webrockittypes',type)
    else
      return {:status => "error", :message => "must delete checks tied to #{type} first"}.to_json
    end
  end

  def self.list()
    return RiakHelper.listKeysFromIndex('webrockittypes','type')
  end

  def self.fetch(type)
    return RiakHelper.fetch('webrockittypes',type)
  end
end