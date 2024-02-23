class Disciplina < ActiveRecord::Base
 
  scope :orden_id, -> {order("id")}

  has_many :materiales_educativos, class_name: "MaterialEducativo"
  
end