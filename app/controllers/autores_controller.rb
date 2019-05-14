class AutoresController < ApplicationController
  before_action :set_autor, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /autores
  # GET /autores.json
  def index
    @autores = Autor.all
    cities = Array.new(@autores.length)
    i = 0
    @autores.each do |autor|
      cid = Cidade.find_by id: autor["cidade_id"]
      if cid == nil
        cities[i] = ""
      else
        cities[i] = cid["nome"]
      end
      i += 1
    end
    @cities = cities
  end

  # GET /autores/1
  # GET /autores/1.json
  def show
    aut = Autor.find(params[:id])
    cid = Cidade.find_by id: aut["cidade_id"]
    if cid == nil
      @city = ""
    else
      @city = cid["nome"]
    end
  end

  # GET /autores/new
  def new
    @autor = Autor.new
  end

  # GET /autores/1/edit
  def edit
  end

  # POST /autores
  # POST /autores.json
  def create
    # p "------------------------------"
    # p autor_params["cidade_id"]
    # p "------------------------------"
    cid = Cidade.find_by nome: autor_params["cidade_id"]
    aut = autor_params
    aut["cidade_id"] = cid["id"]
    @autor = Autor.new(aut)

    respond_to do |format|
      if @autor.save
        format.html { redirect_to @autor, notice: 'Autor was successfully created.' }
        format.json { render :show, status: :created, location: @autor }
      else
        format.html { render :new }
        format.json { render json: @autor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /autores/1
  # PATCH/PUT /autores/1.json
  def update
    respond_to do |format|
      if @autor.update(autor_params)
        format.html { redirect_to @autor, notice: 'Autor was successfully updated.' }
        format.json { render :show, status: :ok, location: @autor }
      else
        format.html { render :edit }
        format.json { render json: @autor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /autores/1
  # DELETE /autores/1.json
  def destroy
    @autor.destroy
    respond_to do |format|
      format.html { redirect_to autores_url, notice: 'Autor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_autor
      @autor = Autor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def autor_params
      params.require(:autor).permit(:pseudonimo_id, :pseudonimo, :cidade_id, :alcunha, :nome, :datanasc, :realnasc, :datamorte, :realmorte, :biografia)
    end
end
