class Historicoflexao < ApplicationRecord
  has_many :flexao, :class_name => 'Flexao', :foreign_key => 'histflexatual_id'
end
