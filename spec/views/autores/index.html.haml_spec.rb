require 'rails_helper'

RSpec.describe "autores/index", type: :view do
  before(:each) do
    assign(:autores, [
      Autor.create!(
        :pseudonimo_id => 2,
        :pseudonimo => "Pseudonimo",
        :cidade => nil,
        :alcunha => "Alcunha",
        :nome => "Nome",
        :realnasc => "Realnasc",
        :realmorte => "Realmorte",
        :biografia => "Biografia"
      ),
      Autor.create!(
        :pseudonimo_id => 2,
        :pseudonimo => "Pseudonimo",
        :cidade => nil,
        :alcunha => "Alcunha",
        :nome => "Nome",
        :realnasc => "Realnasc",
        :realmorte => "Realmorte",
        :biografia => "Biografia"
      )
    ])
  end

  it "renders a list of autores" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Pseudonimo".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Alcunha".to_s, :count => 2
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "Realnasc".to_s, :count => 2
    assert_select "tr>td", :text => "Realmorte".to_s, :count => 2
    assert_select "tr>td", :text => "Biografia".to_s, :count => 2
  end
end
