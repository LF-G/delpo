require 'rails_helper'

RSpec.describe "editoras/new", type: :view do
  before(:each) do
    assign(:editora, Editora.new(
      :nome => "MyString",
      :cidade => nil
    ))
  end

  it "renders new editora form" do
    render

    assert_select "form[action=?][method=?]", editoras_path, "post" do

      assert_select "input[name=?]", "editora[nome]"

      assert_select "input[name=?]", "editora[cidade_id]"
    end
  end
end
