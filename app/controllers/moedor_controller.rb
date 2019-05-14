class MoedorController < ApplicationController #ActionController::Base
  protect_from_forgery with: :null_session

  def new
    #necessario somente para impedir usuarios sem permissao de usar o moedor
    #o melhor seria criar um alias para o moedor
    #authorize! :read, @moedor
  end

  def moer
    #authorize! :read, @moedor

    moe = Moedor.new(params[:file].tempfile, params[:data])
    moe.processa_contextos
    @@contextos = moe.contextos
    @@contextos_final = moe.contextos_final
    @@palavras = moe.palavras
    @@color = moe.color
    @@taq2 = moe.taq2
  end

  def analise
    #authorize! :read, @moedor
    @contextos = @@contextos
    @contextos_final = @@contextos_final
    @palavras = @@palavras
    @color = @@color
    @taq2 = @@taq2
  end
end
