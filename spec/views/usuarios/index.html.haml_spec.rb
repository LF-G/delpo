require 'rails_helper'

RSpec.describe "usuarios/index", type: :view do
  before(:each) do
    assign(:usuarios, [
      Usuario.create!(
        :level => 2,
        :username => "Username",
        :password_digest => "Password Digest",
        :email => "Email@usp.br",
        :nome => "Nome",
        :instituicao => "Instituicao",
        :lattes => "Lattes",
        :abreviatura => "Abreviatura",
        :filologia => false,
        :edicao => false,
        :programador => false,
        :produtivo => false
      ),
      Usuario.create!(
        :level => 2,
        :username => "Username",
        :password_digest => "Password Digest",
        :email => "Email@usp.br",
        :nome => "Nome",
        :instituicao => "Instituicao",
        :lattes => "Lattes",
        :abreviatura => "Abreviatura",
        :filologia => false,
        :edicao => false,
        :programador => false,
        :produtivo => false
      )
    ])
  end

  it "renders a list of usuarios" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    assert_select "tr>td", :text => "Password Digest".to_s, :count => 2
    assert_select "tr>td", :text => "Email@usp.br".to_s, :count => 2
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "Instituicao".to_s, :count => 2
    assert_select "tr>td", :text => "Lattes".to_s, :count => 2
    assert_select "tr>td", :text => "Abreviatura".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 8
    assert_select "tr>td", :text => false.to_s, :count => 8
    assert_select "tr>td", :text => false.to_s, :count => 8
    assert_select "tr>td", :text => false.to_s, :count => 8
  end
end
