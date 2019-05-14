class Datacao < ApplicationRecord
  belongs_to :anterior, :class_name => 'Datacao'
  belongs_to :moderador, :class_name => 'Usuario'
  has_many :anterior, :class_name => 'Datacao', :foreign_key => 'anterior_id'
  belongs_to :usuario

end
