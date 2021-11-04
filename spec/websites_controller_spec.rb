require 'rails_helper'

describe WebsitesController, type: :controller do
  it 'should be able to destroy a website' do
    #@website = "test html website"
    @params = ActionController::Parameters.new(website: {website_address:"test address", username: "test user"})
    :create
    #expect(response).to eq('')
  end 
end 