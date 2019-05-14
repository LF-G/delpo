# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_16_223156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acepcoes", force: :cascade do |t|
    t.bigint "metalema_id"
    t.bigint "hiperlema_id"
    t.string "acepcao", limit: 50
    t.string "imagem", limit: 50
    t.string "fonte_imagem", limit: 50
    t.boolean "ghost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "histacepatual_id"
    t.index ["hiperlema_id"], name: "index_acepcoes_on_hiperlema_id"
    t.index ["histacepatual_id"], name: "index_acepcoes_on_histacepatual_id"
    t.index ["metalema_id"], name: "index_acepcoes_on_metalema_id"
  end

  create_table "acepcoes_acepcoes", id: false, force: :cascade do |t|
    t.bigint "subordinante_id"
    t.bigint "subordinado_id"
    t.boolean "certeza"
    t.index ["subordinado_id"], name: "index_acepcoes_acepcoes_on_subordinado_id"
    t.index ["subordinante_id"], name: "index_acepcoes_acepcoes_on_subordinante_id"
  end

  create_table "acepcoes_ultralemas", id: false, force: :cascade do |t|
    t.bigint "acepcao_id"
    t.bigint "ultralema_id"
    t.index ["acepcao_id"], name: "index_acepcoes_ultralemas_on_acepcao_id"
    t.index ["ultralema_id"], name: "index_acepcoes_ultralemas_on_ultralema_id"
  end

  create_table "autores", force: :cascade do |t|
    t.integer "pseudonimo_id"
    t.string "pseudonimo"
    t.bigint "cidade_id"
    t.string "alcunha"
    t.string "nome"
    t.date "datanasc"
    t.string "realnasc"
    t.date "datamorte"
    t.string "realmorte"
    t.string "biografia"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cidade_id"], name: "index_autores_on_cidade_id"
  end

  create_table "cidades", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conteudos", id: false, force: :cascade do |t|
    t.string "nome", null: false
    t.text "conteudo_pt", null: false
    t.text "conteudo_eng", null: false
    t.string "atualizado_por", null: false
    t.date "ultima_atualizacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contextos", force: :cascade do |t|
    t.bigint "obra_id"
    t.string "conteudo", limit: 2048
    t.boolean "fake"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["obra_id"], name: "index_contextos_on_obra_id"
  end

  create_table "datacoes", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "ocorrencia_id", null: false
    t.integer "anterior_id"
    t.integer "moderador_id"
    t.datetime "horario", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ocorrencia_id"], name: "index_datacoes_on_ocorrencia_id"
    t.index ["usuario_id"], name: "index_datacoes_on_usuario_id"
  end

  create_table "editoras", force: :cascade do |t|
    t.string "nome"
    t.bigint "cidade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cidade_id"], name: "index_editoras_on_cidade_id"
  end

  create_table "flexoes", force: :cascade do |t|
    t.bigint "acepcao_id"
    t.string "flexao", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "histflexatual_id"
    t.index ["acepcao_id"], name: "index_flexoes_on_acepcao_id"
    t.index ["histflexatual_id"], name: "index_flexoes_on_histflexatual_id"
  end

  create_table "hemilemas", force: :cascade do |t|
    t.string "hemilema", limit: 50
    t.string "hemflex", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hiperlemas", force: :cascade do |t|
    t.bigint "principal_id"
    t.string "hiperlema", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hiperlemas_ultralemas", id: false, force: :cascade do |t|
    t.integer "hiperlema_id", null: false
    t.integer "ultralema_id", null: false
    t.index ["hiperlema_id"], name: "index_hiperlemas_ultralemas_on_hiperlema_id"
    t.index ["ultralema_id"], name: "index_hiperlemas_ultralemas_on_ultralema_id"
  end

  create_table "historicoacepcoes", force: :cascade do |t|
    t.bigint "anterior_id"
    t.string "acepcao_etimologia", limit: 4096
    t.string "usuario_assinatura", limit: 128
    t.string "definicao", limit: 1024
    t.string "acepcao_classsemant", limit: 50
    t.string "acepcao_classmorf", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historicoflexoes", force: :cascade do |t|
    t.bigint "anterior_id"
    t.string "flexao_etimologia", limit: 2048
    t.string "usuario_assinatura", limit: 128
    t.string "flexao_classmorf", limit: 250
    t.integer "flexao_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metalemas", force: :cascade do |t|
    t.string "metalema", limit: 50
    t.boolean "ghost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "obra_autores", id: false, force: :cascade do |t|
    t.bigint "obra_id"
    t.bigint "autor_id"
    t.string "tipo", limit: 20
    t.boolean "incerteza"
    t.index ["autor_id"], name: "index_obra_autores_on_autor_id"
    t.index ["obra_id"], name: "index_obra_autores_on_obra_id"
  end

  create_table "obra_editoras", id: false, force: :cascade do |t|
    t.bigint "obra_id"
    t.bigint "editora_id"
    t.index ["editora_id"], name: "index_obra_editoras_on_editora_id"
    t.index ["obra_id"], name: "index_obra_editoras_on_obra_id"
  end

  create_table "obras", force: :cascade do |t|
    t.bigint "autorint_id"
    t.integer "organizador_id"
    t.integer "editor_id"
    t.bigint "editora_id"
    t.date "texto_data"
    t.string "texto_data_real"
    t.date "publicacao_data"
    t.string "publicacao_data_real"
    t.text "texto_titulo"
    t.text "publicacao_titulo"
    t.text "texto_local"
    t.string "localiz"
    t.string "edicao_numero"
    t.string "edicao_volume"
    t.string "edicao_tipo"
    t.string "cota"
    t.string "univdisc"
    t.string "genero"
    t.string "suporte"
    t.string "concedente"
    t.text "comentarios"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "autormat_id"
    t.boolean "moedor"
    t.index ["autorint_id"], name: "index_obras_on_autorint_id"
    t.index ["editora_id"], name: "index_obras_on_editora_id"
  end

  create_table "ocorrencias", force: :cascade do |t|
    t.bigint "variante_id"
    t.bigint "hemilema_id"
    t.bigint "contexto_id", null: false
    t.string "ocorrencia", null: false
    t.integer "add_direita", null: false
    t.integer "add_esquerda", null: false
    t.integer "iter", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contexto_id"], name: "index_ocorrencias_on_contexto_id"
    t.index ["hemilema_id"], name: "index_ocorrencias_on_hemilema_id"
    t.index ["variante_id"], name: "index_ocorrencias_on_variante_id"
  end

  create_table "ocorrencias_resultados", id: false, force: :cascade do |t|
    t.bigint "ocorrencia_id"
    t.bigint "resultado_id"
    t.index ["ocorrencia_id"], name: "index_ocorrencias_resultados_on_ocorrencia_id"
    t.index ["resultado_id"], name: "index_ocorrencias_resultados_on_resultado_id"
  end

  create_table "resultados", force: :cascade do |t|
    t.date "taq"
    t.integer "classificacao"
    t.string "metalema", null: false
    t.boolean "ativo", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sessao_id", null: false
    t.index ["sessao_id"], name: "index_resultados_on_sessao_id"
  end

  create_table "sessoes", force: :cascade do |t|
    t.datetime "data", null: false
    t.string "relatorio", null: false
    t.bigint "obra_id"
    t.boolean "mostrar", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "usuario_id"
    t.index ["obra_id"], name: "index_sessoes_on_obra_id"
    t.index ["usuario_id"], name: "index_sessoes_on_usuario_id"
  end

  create_table "ultralemas", force: :cascade do |t|
    t.bigint "remota"
    t.string "ultralema", limit: 50
    t.string "lingua", limit: 50
    t.string "comentario", limit: 4096
    t.string "assinatura", limit: 200
    t.boolean "ultra_remoto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "level", null: false
    t.string "username", null: false
    t.string "nome", null: false
    t.string "instituicao"
    t.string "lattes"
    t.string "abreviatura"
    t.boolean "filologia", default: false
    t.boolean "edicao", default: false
    t.boolean "programador", default: false
    t.boolean "produtivo", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  create_table "variantes", force: :cascade do |t|
    t.bigint "flexao_id"
    t.integer "ocorrenciataq_id"
    t.string "variante"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flexao_id"], name: "index_variantes_on_flexao_id"
  end

  add_foreign_key "acepcoes", "hiperlemas"
  add_foreign_key "acepcoes", "historicoacepcoes", column: "histacepatual_id"
  add_foreign_key "acepcoes", "metalemas"
  add_foreign_key "acepcoes_acepcoes", "acepcoes", column: "subordinado_id"
  add_foreign_key "acepcoes_acepcoes", "acepcoes", column: "subordinante_id"
  add_foreign_key "autores", "cidades"
  add_foreign_key "contextos", "obras"
  add_foreign_key "editoras", "cidades"
  add_foreign_key "flexoes", "acepcoes"
  add_foreign_key "flexoes", "historicoflexoes", column: "histflexatual_id"
  add_foreign_key "obra_autores", "autores"
  add_foreign_key "obra_autores", "obras"
  add_foreign_key "obras", "autores", column: "autorint_id"
  add_foreign_key "obras", "editoras"
  add_foreign_key "ocorrencias", "contextos"
  add_foreign_key "ocorrencias", "hemilemas"
  add_foreign_key "ocorrencias", "variantes"
  add_foreign_key "resultados", "sessoes"
  add_foreign_key "sessoes", "obras"
  add_foreign_key "sessoes", "usuarios"
  add_foreign_key "variantes", "flexoes"
end
