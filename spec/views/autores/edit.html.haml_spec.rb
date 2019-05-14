require 'rails_helper'

RSpec.describe "autores/edit", type: :view do
  before(:each) do
    @autor = assign(:autor, Autor.create!(
      :pseudonimo_id => 1,
      :pseudonimo => "MyString",
      :cidade => nil,
      :alcunha => "MyString",
      :nome => "MyString",
      :realnasc => "MyString",
      :realmorte => "MyString",
      :biografia => "MyString"
    ))
  end

  it "renders the edit autor form" do
    render

    assert_select "form[action=?][method=?]", autor_path(@autor), "post" do

      assert_select "input[name=?]", "autor[pseudonimo_id]"

      assert_select "input[name=?]", "autor[pseudonimo]"

      assert_select "input[name=?]", "autor[cidade_id]"

      assert_select "input[name=?]", "autor[alcunha]"

      assert_select "input[name=?]", "autor[nome]"

      assert_select "input[name=?]", "autor[realnasc]"

      assert_select "input[name=?]", "autor[realmorte]"

      assert_select "input[name=?]", "autor[biografia]"
    end
  end
end
