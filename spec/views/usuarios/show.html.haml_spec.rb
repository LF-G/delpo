require 'rails_helper'

RSpec.describe "usuarios/show", type: :view do
  before(:each) do
    @usuario = assign(:usuario, Usuario.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Password Digest/)
    expect(rendered).to match(/Email@usp.br/)
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Instituicao/)
    expect(rendered).to match(/Lattes/)
    expect(rendered).to match(/Abreviatura/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
