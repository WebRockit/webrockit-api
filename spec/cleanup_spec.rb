require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "group D Fetching" do

  describe "/deleteType" do
    it "should delete a type with the name sometype1" do
      basic_authorize('admin','admin')
      type_call = URI.encode('type=sometype1')
      get "/v1/deleteType?#{type_call}"
      last_response.should be_ok
      res = last_response.body
      res.should match('{"status":"ok"}')
    end
  end

  describe "/deletePoller" do
    it "should delete a poller with the name somepoller1" do
      basic_authorize('admin','admin')
      poller_call = URI.encode('poller=somepoller1')
      get "/v1/deletePoller?#{poller_call}"
      last_response.should be_ok
      res = last_response.body
      res.should match('{"status":"ok"}')
    end
  end

  describe "/deleteCheck" do
    it "should delete a check with the name hosting.sometype1.blah.blah" do
      basic_authorize('admin','admin')
      check_call = URI.encode('type=sometype1&name=hosting.sometype1.blah.blah')
      get "/v1/deleteCheck?#{check_call}"
      last_response.should be_ok
      res = last_response.body
      res.should match('{"status":"ok"}')
    end
  end

end