require 'rails_helper'

RSpec.describe "obras/index", type: :view do
  before(:each) do
    assign(:obras, [
      Obra.create!(
        :autor => nil,
        :organizador_id => 2,
        :editor_id => 3,
        :editora => nil,
        :texto_data_real => "Texto Data Real",
        :publicacao_data_real => "Publicacao Data Real",
        :texto_titulo => "MyText",
        :publicacao_titulo => "MyText",
        :texto_local => "MyText",
        :localiz => "Localiz",
        :edicao_numero => "Edicao Numero",
        :edicao_volume => "Edicao Volume",
        :edicao_tipo => "Edicao Tipo",
        :cota => "Cota",
        :univdisc => "Univdisc",
        :genero => "Genero",
        :suporte => "Suporte",
        :concedente => "Concedente",
        :comentarios => "MyText",
        :moedor => 4
      ),
      Obra.create!(
        :autor => nil,
        :organizador_id => 2,
        :editor_id => 3,
        :editora => nil,
        :texto_data_real => "Texto Data Real",
        :publicacao_data_real => "Publicacao Data Real",
        :texto_titulo => "MyText",
        :publicacao_titulo => "MyText",
        :texto_local => "MyText",
        :localiz => "Localiz",
        :edicao_numero => "Edicao Numero",
        :edicao_volume => "Edicao Volume",
        :edicao_tipo => "Edicao Tipo",
        :cota => "Cota",
        :univdisc => "Univdisc",
        :genero => "Genero",
        :suporte => "Suporte",
        :concedente => "Concedente",
        :comentarios => "MyText",
        :moedor => 4
      )
    ])
  end

  it "renders a list of obras" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Texto Data Real".to_s, :count => 2
    assert_select "tr>td", :text => "Publicacao Data Real".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Localiz".to_s, :count => 2
    assert_select "tr>td", :text => "Edicao Numero".to_s, :count => 2
    assert_select "tr>td", :text => "Edicao Volume".to_s, :count => 2
    assert_select "tr>td", :text => "Edicao Tipo".to_s, :count => 2
    assert_select "tr>td", :text => "Cota".to_s, :count => 2
    assert_select "tr>td", :text => "Univdisc".to_s, :count => 2
    assert_select "tr>td", :text => "Genero".to_s, :count => 2
    assert_select "tr>td", :text => "Suporte".to_s, :count => 2
    assert_select "tr>td", :text => "Concedente".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
