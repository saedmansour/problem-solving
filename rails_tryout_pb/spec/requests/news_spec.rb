require 'rails_helper'

describe NewsController, :type => :controller do
	before do
    user = FactoryGirl.build_stubbed :user, :admin
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

	describe "index" do
	  it 'shows a list of the latest news' do

	    FactoryGirl.create_list(:news, 10)

	    get 'index'

	    json = JSON.parse(response.body)

	    expect(response).to be_success

	    expect(json['news'].length).to eq(10)
	  end
	end
end