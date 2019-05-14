class ObrasController < ApplicationController
  before_action :set_obra, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /obras
  # GET /obras.json
  def index
    @obras = Obra.all
    autores = Array.new(@obras.length)
    editoras = Array.new(@obras.length)
    i = 0
    @obras.each do |obra|
      aut = Autor.find_by id: obra["autorint_id"]
      edi = Editora.find_by id: obra["editora_id"]
      if aut == nil
        autores[i] = ""
      else
        autores[i] = aut["nome"]
      end
      if edi == nil
        editoras[i] = ""
      else
        editoras[i] = edi["nome"]
      end
      i += 1
    end
    @autores = autores
    @editoras = editoras
  end

  # GET /obras/1
  # GET /obras/1.json
  def show
    ob = Obra.find(params[:id])
    aut = Autor.find_by id: ob["autorint_id"]
    edi = Editora.find_by id: ob["editora_id"]
    if aut == nil
      @autor = ""
    else
      @autor = aut["nome"]
    end
    if edi == nil
      @editora = ""
    else
      @editora = edi["nome"]
    end
  end

  # GET /obras/new
  def new
    @obra = Obra.new
  end

  # GET /obras/1/edit
  def edit
  end

  # POST /obras
  # POST /obras.json
  def create
    ob = obra_params
    aut = Autor.find_by nome: ob["autorint_id"]
    edi = Editora.find_by nome: ob["editora_id"]
    ob["autorint_id"] = aut["id"]
    ob["editora_id"] = edi["id"]
    @obra = Obra.new(ob)

    respond_to do |format|
      if @obra.save
        format.html { redirect_to @obra, notice: 'Obra was successfully created.' }
        format.json { render :show, status: :created, location: @obra }
      else
        format.html { render :new }
        format.json { render json: @obra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /obras/1
  # PATCH/PUT /obras/1.json
  def update
    respond_to do |format|
      if @obra.update(obra_params)
        format.html { redirect_to @obra, notice: 'Obra was successfully updated.' }
        format.json { render :show, status: :ok, location: @obra }
      else
        format.html { render :edit }
        format.json { render json: @obra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /obras/1
  # DELETE /obras/1.json
  def destroy
    @obra.destroy
    respond_to do |format|
      format.html { redirect_to obras_url, notice: 'Obra was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_obra
      @obra = Obra.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def obra_params
      params.require(:obra).permit(:autor_id, :organizador_id, :editor_id, :editora_id, :texto_data, :texto_data_real, :publicao_data, :publicacao_data_real, :texto_titulo, :publicacao_titulo, :texto_local, :localiz, :edicao_numero, :edicao_volume, :edicao_tipo, :cota, :univdisc, :genero, :suporte, :concedente, :comentarios, :moedor)
    end
end
