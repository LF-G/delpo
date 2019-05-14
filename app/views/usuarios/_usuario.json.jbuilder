json.extract! usuario, :id, :level, :username, :password, :email, :nome, :instituicao, :lattes, :abreviatura, :filologia, :edicao, :programador, :produtivo, :created_at, :updated_at
json.url usuario_url(usuario, format: :json)
