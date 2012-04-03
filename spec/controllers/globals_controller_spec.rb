require 'spec_helper'

describe GlobalsController do

  describe "GET 'year:integer'" do
    it "returns http success" do
      get 'year:integer'
      response.should be_success
    end
  end

  describe "GET 'multiplier:decimal'" do
    it "returns http success" do
      get 'multiplier:decimal'
      response.should be_success
    end
  end

end
