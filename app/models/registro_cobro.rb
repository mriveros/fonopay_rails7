class RegistroCobro < ActiveRecord::Base

  self.table_name="registros_cobros"
  self.primary_key="id"
  
  #attr_accessible :id, :cita_id, :fecha_cobro, :metodo_pago_id, :estado_cobro_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
  
end