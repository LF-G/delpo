require 'rails_helper'

RSpec.describe Usuario, type: :model do
  describe 'deve funcionar' do
    it 'bom exemplo' do
      teste = Usuario.create(:nome => 'John Doe',
                             :email => 'john@server.com',
                             :username => 'johnd',
                             :password => 'segredo123',
                             :password_confirmation => 'segredo123')
      expect(teste.save!).to be true
    end

    it 'com canpos opcionais' do
      teste = Usuario.create(:nome => 'John Doe',
                             :email => 'john@server.com',
                             :username => 'johnd',
                             :password => 'segredo123',
                             :password_confirmation => 'segredo123',
                             :instituicao => 'Ime-USP',
                             :lattes => 'http://lattes.cnpq.br/1234',
                             :edicao => true)
      expect(teste.save!).to be true
    end
  end

  describe 'nao deveria funcionar' do
    it 'falta nome' do
      teste = Usuario.create(:email => 'john@server.com',
                             :username => 'johnd',
                             :password => 'segredo123',
                             :password_confirmation => 'segredo123')
      expect(teste.save).to be false
    end

    it 'falta email' do
      teste = Usuario.create(:nome => 'John Doe',
                             :username => 'johnd',
                             :password => 'segredo123',
                             :password_confirmation => 'segredo123')
      expect(teste.save).to be false
    end

    it 'email invalido' do
      teste = Usuario.create(:nome => 'John Doe',
                             :email => 'johncom',
                             :username => 'johnd',
                             :password => 'segredo123',
                             :password_confirmation => 'segredo123')
      expect(teste.save).to be false
    end

    it 'falta password' do
      teste = Usuario.create(:nome => 'John Doe',
                             :email => 'john@server.com',
                             :username => 'johnd')
      expect(teste.save).to be false
    end

    it 'falta username' do
      teste = Usuario.create(:nome => 'John Doe',
                             :email => 'john@server.com',
                             :password => 'segredo123',
                             :password_confirmation => 'segredo123')
      expect(teste.save).to be false
    end

    it 'campo opcional grande demais' do
      teste = Usuario.create(:nome => 'John Doe',
                             :email => 'john@server.com',
                             :username => 'johnd',
                             :password => 'segredo123',
                             :password_confirmation => 'segredo123',
                             :instituicao => 'Ime-USP',
                             :lattes => 'argaasdvcqw3opi9reofinm7182p9roqwouifcnqpodvniapsuodifaismfnuqpeworifmnaospudvin03894nf89f1n3ofqwrlkjsnv983oi4ngfqo0v8n909813ngroidjkfnva,dfmvq8o034nfqinv9qpe8fvn89q3po4infqeklvnv8931njlkrfnasdf9v8p3o1n4gfojsaklnv893q24oinqgdslakvn389q4oigkjnvsoapvinq3w9804ivna9wpovslknv93q8ewronv9d8poi3nq98pioewrnv9p8qweoirnv98pq3iown4v9poiuqnw9pv8auiosn',
                             :edicao => true)
      expect(teste.save).to be false
    end
  end
end
