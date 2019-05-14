
class ApplicationController < ActionController::Base
  #somente a home nao exige login
  before_action :authenticate_usuario!, except: [:index]
  #metodo que define parametros aceitos no devise
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  #verifica se o usuario tem permissao. Definicoes no model/ability.rb
  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end

  #parametros aceitos pelo usuario para registro e login
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :level, :instituicao, :lattes, :abreviatura, :filologia, :edicao, :programador, :produtivo, :nome])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :password])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', :alert => 'Você não tem permissão'
  end
end
