class Obra < ApplicationRecord
  belongs_to :autor
  belongs_to :editora
  has_and_belongs_to_many :editoras
  has_and_belongs_to_many :autores
end
