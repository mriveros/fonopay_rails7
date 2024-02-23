class VTutorDetalle < ActiveRecord::Base

  self.table_name="v_tutores_detalles"
  self.primary_key="tutor_detalle_id"
  
  scope :orden_01, -> { order("tutor_detalle_id")}
  
end