require 'rails_helper'

RSpec.describe "editoras/edit", type: :view do
  before(:each) do
    @editora = assign(:editora, Editora.create!(
      :nome => "MyString",
      :cidade => nil
    ))
  end

  it "renders the edit editora form" do
    render

    assert_select "form[action=?][method=?]", editora_path(@editora), "post" do

      assert_select "input[name=?]", "editora[nome]"

      assert_select "input[name=?]", "editora[cidade_id]"
    end
  end
end
