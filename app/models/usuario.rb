class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :rememberable, :recoverable
  validates :username, presence: true
  validates :nome, presence: true
  validates :email,
            presence: true,
            :format => { :with => %r{[\w\d]+@[\w]+\.[\w]+}, :message => 'nao valido' }
  validates :instituicao, length: {maximum: 200}, allow_blank: true
  validates :lattes, length: {maximum: 200}, allow_blank: true
  validates :abreviatura, length: {maximum: 200}, allow_blank: true
  #validates_inclusion_of :level, :in => 0..5
  validates_uniqueness_of :username

  has_many :moderado, :class_name => 'Datacao', :foreign_key => 'moderador_id'
  has_many :sessoes
  has_many :datacoes


  def inverte_filologia
    self.filologia = !self.filologia
  end

  def inverte_edicao
    self.edicao = !self.edicao
  end

  def inverte_programador
    self.programador = !self.programador
  end

  def inverte_produtivo
    self.produtivo = !self.produtivo
  end
end
