FactoryBot.define do
  factory :obra do
    autor nil
    organizador_id 1
    editor_id 1
    editora nil
    texto_data "2018-08-31"
    texto_data_real "MyString"
    publicao_data "2018-08-31"
    publicacao_data_real "MyString"
    texto_titulo "MyText"
    publicacao_titulo "MyText"
    texto_local "MyText"
    localiz "MyString"
    edicao_numero "MyString"
    edicao_volume "MyString"
    edicao_tipo "MyString"
    cota "MyString"
    univdisc "MyString"
    genero "MyString"
    suporte "MyString"
    concedente "MyString"
    comentarios "MyText"
    moedor 1
  end
end
