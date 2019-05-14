require 'rails_helper'

RSpec.describe "editoras/show", type: :view do
  before(:each) do
    @editora = assign(:editora, Editora.create!(
      :nome => "Nome",
      :cidade => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(//)
  end
end
