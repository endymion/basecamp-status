require 'spec_helper'
require 'fakeweb'

describe BoardsController do

before(:each) do
  FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/projects.xml',
                       :response => File.expand_path('test/fixtures/projects.xml'))
end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should have a Board instance variable" do
      get 'index'
      assigns(:board).should == @b
    end

    it "should have a non nil Projects instance varible" do
      get 'index'
      assigns(:projects).should == @p      
    end

  end

end
