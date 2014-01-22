require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "group C Fetching" do

  describe "/createCheck" do
    it "should create a check with the name hosting.sometype1.blah.blah" do
      basic_authorize('admin','admin')
      check_call = URI.encode('type=sometype1&name=hosting.sometype1.blah.blah&interval=300&application=wordpress&url=http://something&ipaddress=1.2.3.4')
      get "/v1/createCheck?#{check_call}"
      last_response.should be_ok
      res = last_response.body
      res.should match('{"status":"ok"}')
    end
  end

  describe "/listChecks" do
    it "should fetch a check with the name hosting.sometype1.blah.blah for sometype1" do
      basic_authorize('admin','admin')
      check_call = URI.encode('type=sometype1')
      get "/v1/listChecks?#{check_call}"
      last_response.should be_ok
      res = last_response.body
      res.should match('hosting.sometype1.blah.blah')
    end
  end

  describe "/fetchCheck" do
    it "should fetch a check with the name hosting.sometype1.blah.blah and show ipaddress" do
      basic_authorize('admin','admin')
      check_call = URI.encode('type=sometype1&name=hosting.sometype1.blah.blah')
      get "/v1/fetchCheck?#{check_call}"
      last_response.should be_ok
      res = last_response.body
      res.should match('1.2.3.4')
    end
  end

end