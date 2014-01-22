module PollerHelper
  def self.create(poller,description)
    key = poller
    indexes = ['poller',poller]
    jsondoc = {
      'name' => poller,
      'description' => description
    }
    return RiakHelper.add('webrockitpollers',key,indexes,jsondoc)
  end

  def self.delete(poller)
    return RiakHelper.delete('webrockitpollers',poller)
  end

  def self.list()
    return RiakHelper.listKeysFromIndex('webrockitpollers','poller')
  end

  def self.fetch(poller)
    return RiakHelper.fetch('webrockitpollers',poller)
  end
end