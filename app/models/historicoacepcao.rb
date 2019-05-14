class Historicoacepcao < ApplicationRecord
  has_many :acepcao, :class_name => 'Acepcao', :foreign_key => 'histacepcatual_id'
end
