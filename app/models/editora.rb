class Editora < ApplicationRecord
  belongs_to :cidade
  has_and_belongs_to_many :obras
end
