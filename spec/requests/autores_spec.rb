require 'rails_helper'

RSpec.describe "Autores", type: :request do
  describe "GET /autores" do
    it "works! (now write some real specs)" do
      get autores_path
      expect(response).to have_http_status(200)
    end
  end
end
