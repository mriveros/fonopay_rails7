class Cargo < ActiveRecord::Base
  
  self.table_name= "cargos"
  self.primary_key = "id"
  
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

end
