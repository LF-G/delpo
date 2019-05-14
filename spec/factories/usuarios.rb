FactoryBot.define do
  factory :usuario do
    level 1
    username "MyString"
    password_digest "MyString"
    email "MyString@usp.br"
    nome "MyString"
    instituicao "MyString"
    lattes "MyString"
    abreviatura "MyString"
    filologia false
    edicao false
    programador false
    produtivo false
  end
end
