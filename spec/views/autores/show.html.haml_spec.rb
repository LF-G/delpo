require 'rails_helper'

RSpec.describe "autores/show", type: :view do
  before(:each) do
    @autor = assign(:autor, Autor.create!(
      :pseudonimo_id => 2,
      :pseudonimo => "Pseudonimo",
      :cidade => nil,
      :alcunha => "Alcunha",
      :nome => "Nome",
      :realnasc => "Realnasc",
      :realmorte => "Realmorte",
      :biografia => "Biografia"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Pseudonimo/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Alcunha/)
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Realnasc/)
    expect(rendered).to match(/Realmorte/)
    expect(rendered).to match(/Biografia/)
  end
end
