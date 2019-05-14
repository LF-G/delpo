class Acepcao < ApplicationRecord
  belongs_to :metalema
  belongs_to :hiperlema
  belongs_to :historicoacepcao, :class_name => 'Historicoacepcao'
  has_and_belongs_to_many :ultralemas
end
