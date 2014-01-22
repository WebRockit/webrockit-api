require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "group B Fetching" do

  describe "/createPoller" do
    it "should create a poller with the name somepoller1" do
      basic_authorize('admin','admin')
      poller_call = URI.encode('poller=somepoller1&description=This is a poller')
      get "/v1/createPoller?#{poller_call}"
      last_response.should be_ok
      res = last_response.body
      res.should match('{"status":"ok"}')
    end
  end

  describe "/listPollers" do
    it "should list a poller with the name somepoller1" do
      basic_authorize('admin','admin')
      get "/v1/listPollers?"
      last_response.should be_ok
      res = last_response.body
      res.should match('somepoller1')
    end
  end

  describe "/fetchPoller" do
    it "should fetch a poller with the name somepoller1 and show description" do
      basic_authorize('admin','admin')
      poller_call = URI.encode('poller=somepoller1')
      get "/v1/fetchPoller?#{poller_call}"
      last_response.should be_ok
      res = last_response.body
      res.should match('This is a poller')
    end
  end

end