require 'rails_helper'

RSpec.describe "obras/new", type: :view do
  before(:each) do
    assign(:obra, Obra.new(
      :autor => nil,
      :organizador_id => 1,
      :editor_id => 1,
      :editora => nil,
      :texto_data_real => "MyString",
      :publicacao_data_real => "MyString",
      :texto_titulo => "MyText",
      :publicacao_titulo => "MyText",
      :texto_local => "MyText",
      :localiz => "MyString",
      :edicao_numero => "MyString",
      :edicao_volume => "MyString",
      :edicao_tipo => "MyString",
      :cota => "MyString",
      :univdisc => "MyString",
      :genero => "MyString",
      :suporte => "MyString",
      :concedente => "MyString",
      :comentarios => "MyText",
      :moedor => 1
    ))
  end

  it "renders new obra form" do
    render

    assert_select "form[action=?][method=?]", obras_path, "post" do

      assert_select "input[name=?]", "obra[autor_id]"

      assert_select "input[name=?]", "obra[organizador_id]"

      assert_select "input[name=?]", "obra[editor_id]"

      assert_select "input[name=?]", "obra[editora_id]"

      assert_select "input[name=?]", "obra[texto_data_real]"

      assert_select "input[name=?]", "obra[publicacao_data_real]"

      assert_select "textarea[name=?]", "obra[texto_titulo]"

      assert_select "textarea[name=?]", "obra[publicacao_titulo]"

      assert_select "textarea[name=?]", "obra[texto_local]"

      assert_select "input[name=?]", "obra[localiz]"

      assert_select "input[name=?]", "obra[edicao_numero]"

      assert_select "input[name=?]", "obra[edicao_volume]"

      assert_select "input[name=?]", "obra[edicao_tipo]"

      assert_select "input[name=?]", "obra[cota]"

      assert_select "input[name=?]", "obra[univdisc]"

      assert_select "input[name=?]", "obra[genero]"

      assert_select "input[name=?]", "obra[suporte]"

      assert_select "input[name=?]", "obra[concedente]"

      assert_select "textarea[name=?]", "obra[comentarios]"

      assert_select "input[name=?]", "obra[moedor]"
    end
  end
end
