require 'rails_helper'

RSpec.describe "Gigs", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/gigs/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/gigs/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/gigs/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/gigs/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/gigs/show"
      expect(response).to have_http_status(:success)
    end
  end

end
