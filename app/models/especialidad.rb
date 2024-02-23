class Especialidad < ActiveRecord::Base

  self.table_name="especialidades"
  self.primary_key="id"
  
  scope :orden_01, -> { order("id")}
  
end