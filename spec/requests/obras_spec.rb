require 'rails_helper'

RSpec.describe "Obras", type: :request do
  describe "GET /obras" do
    it "works! (now write some real specs)" do
      get obras_path
      expect(response).to have_http_status(200)
    end
  end
end
