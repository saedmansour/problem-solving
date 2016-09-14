require 'rails_helper'

describe SearchService, elasticsearch: true do

  before do
  	ElasticsearchSetup.before
  end

  after do
  	ElasticsearchSetup.after
  end

  describe "News search existing data in database" do
    it "returns results of length 1 this exists in database" do
      result = SearchService.new.search("hello")
      expect(result.size).to eq(1)
    end
  end
end
