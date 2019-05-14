require 'rails_helper'

RSpec.describe "editoras/index", type: :view do
  before(:each) do
    assign(:editoras, [
      Editora.create!(
        :nome => "Nome",
        :cidade => nil
      ),
      Editora.create!(
        :nome => "Nome",
        :cidade => nil
      )
    ])
  end

  it "renders a list of editoras" do
    render
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
