require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Fetching" do

  describe "/" do
    it "should contain schemas" do
      basic_authorize('admin','admin')
      get "/"
      last_response.should be_ok
      res = last_response.body
      res.should match("schemas")
    end
  end

  describe "/schemas" do
    it "should contain resourceFields" do
      basic_authorize('admin','admin')
      get "/schemas"
      last_response.should be_ok
      res = last_response.body
      res.should match("resourceFields")
    end
  end

end