require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "group A Fetching" do

  describe "/createType" do
    it "should create a type with the name sometype1" do
      basic_authorize('admin','admin')
      type_call = URI.encode('type=sometype1&description=This is a type')
      get "/v1/createType?#{type_call}"
      last_response.should be_ok
      res = last_response.body
      res.should match('{"status":"ok"}')
    end
  end

  describe "/listTypes" do
    it "should list a type with the name sometype1" do
      basic_authorize('admin','admin')
      get "/v1/listTypes?"
      last_response.should be_ok
      res = last_response.body
      res.should match('sometype1')
    end
  end

  describe "/fetchType" do
    it "should fetch a type with the name sometype1 and show description" do
      basic_authorize('admin','admin')
      type_call = URI.encode('type=sometype1')
      get "/v1/fetchType?#{type_call}"
      last_response.should be_ok
      res = last_response.body
      res.should match('This is a type')
    end
  end

end