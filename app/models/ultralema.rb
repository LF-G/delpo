class Ultralema < ApplicationRecord
  has_and_belongs_to_many :acepcoes
  has_and_belongs_to_many :hiperlemas
end
