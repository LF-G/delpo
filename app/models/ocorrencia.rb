class Ocorrencia < ApplicationRecord
  belongs_to :variante
  belongs_to :hemilema
  belongs_to :contexto
  has_and_belongs_to_many :resultados
end
