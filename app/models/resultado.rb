class Resultado < ApplicationRecord
  has_and_belongs_to_many :ocorrencias
end
