class NotificacionPersona < ActiveRecord::Base
  
  self.table_name= "notificaciones_personas"
  self.primary_key = "id"
  
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

end