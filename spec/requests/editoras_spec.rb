require 'rails_helper'

RSpec.describe "Editoras", type: :request do
  describe "GET /editoras" do
    it "works! (now write some real specs)" do
      get editoras_path
      expect(response).to have_http_status(200)
    end
  end
end
