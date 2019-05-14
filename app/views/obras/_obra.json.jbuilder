json.extract! obra, :id, :autor_id, :organizador_id, :editor_id, :editora_id, :texto_data, :texto_data_real, :publicao_data, :publicacao_data_real, :texto_titulo, :publicacao_titulo, :texto_local, :localiz, :edicao_numero, :edicao_volume, :edicao_tipo, :cota, :univdisc, :genero, :suporte, :concedente, :comentarios, :moedor, :created_at, :updated_at
json.url obra_url(obra, format: :json)
