require 'rails_helper'

RSpec.describe "usuarios/edit", type: :view do
  before(:each) do
    @usuario = assign(:usuario, Usuario.create!(
      :level => 1,
      :username => "MyString",
      :password_digest => "MyString",
      :email => "MyString@usp.br",
      :nome => "MyString",
      :instituicao => "MyString",
      :lattes => "MyString",
      :abreviatura => "MyString",
      :filologia => false,
      :edicao => false,
      :programador => false,
      :produtivo => false
    ))
  end

  it "renders the edit usuario form" do
    render

    assert_select "form[action=?][method=?]", usuario_path(@usuario), "post" do

      assert_select "input[name=?]", "usuario[level]"

      assert_select "input[name=?]", "usuario[username]"

      assert_select "input[name=?]", "usuario[password_digest]"

      assert_select "input[name=?]", "usuario[email]"

      assert_select "input[name=?]", "usuario[nome]"

      assert_select "input[name=?]", "usuario[instituicao]"

      assert_select "input[name=?]", "usuario[lattes]"

      assert_select "input[name=?]", "usuario[abreviatura]"

      assert_select "input[name=?]", "usuario[filologia]"

      assert_select "input[name=?]", "usuario[edicao]"

      assert_select "input[name=?]", "usuario[programador]"

      assert_select "input[name=?]", "usuario[produtivo]"
    end
  end
end
