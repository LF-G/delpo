require 'rails_helper'

RSpec.describe "obras/show", type: :view do
  before(:each) do
    @obra = assign(:obra, Obra.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Texto Data Real/)
    expect(rendered).to match(/Publicacao Data Real/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Localiz/)
    expect(rendered).to match(/Edicao Numero/)
    expect(rendered).to match(/Edicao Volume/)
    expect(rendered).to match(/Edicao Tipo/)
    expect(rendered).to match(/Cota/)
    expect(rendered).to match(/Univdisc/)
    expect(rendered).to match(/Genero/)
    expect(rendered).to match(/Suporte/)
    expect(rendered).to match(/Concedente/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/4/)
  end
end
