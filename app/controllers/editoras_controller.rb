class EditorasController < ApplicationController
  before_action :set_editora, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /editoras
  # GET /editoras.json
  def index
    @editoras = Editora.all
    cities = Array.new(@editoras.length)
    i = 0
    @editoras.each do |editora|
      cid = Cidade.find_by id: editora["cidade_id"]
      if cid == nil
        cities[i] = ""
      else
        cities[i] = cid["nome"]
      end
      i += 1
    end
    @cities = cities
  end

  # GET /editoras/1
  # GET /editoras/1.json
  def show
    edi = Editora.find(params[:id])
    cid = Cidade.find_by id: edi["cidade_id"]
    if cid == nil
      @city = ""
    else
      @city = cid["nome"]
    end
  end

  # GET /editoras/new
  def new
    @editora = Editora.new
  end

  # GET /editoras/1/edit
  def edit
  end

  # POST /editoras
  # POST /editoras.json
  def create
    # p "------------------------------"
    # p editora_params["cidade_id"]
    # p "------------------------------"
    cid = Cidade.find_by nome: editora_params["cidade_id"]
    ed =  editora_params
    ed["cidade_id"] = cid["id"]
    @editora = Editora.new(ed)

    respond_to do |format|
      if @editora.save
        format.html { redirect_to @editora, notice: 'Editora was successfully created.' }
        format.json { render :show, status: :created, location: @editora }
      else
        format.html { render :new }
        format.json { render json: @editora.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /editoras/1
  # PATCH/PUT /editoras/1.json
  def update
    respond_to do |format|
      if @editora.update(editora_params)
        format.html { redirect_to @editora, notice: 'Editora was successfully updated.' }
        format.json { render :show, status: :ok, location: @editora }
      else
        format.html { render :edit }
        format.json { render json: @editora.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /editoras/1
  # DELETE /editoras/1.json
  def destroy
    @editora.destroy
    respond_to do |format|
      format.html { redirect_to editoras_url, notice: 'Editora was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_editora
      @editora = Editora.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def editora_params
      params.require(:editora).permit(:nome, :cidade_id)
    end
end
