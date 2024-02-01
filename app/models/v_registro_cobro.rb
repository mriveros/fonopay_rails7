class VRegistroCobro < ActiveRecord::Base

  self.table_name="v_citas_registros_cobros"
  self.primary_key="cita_id"
  
  #attr_accessible :cita_id, :fecha_cita,:paciente_id, :paciente_documento, :paciente_nombre, :paciente_apellido,:fecha_cobro, :metodo_pago_id, :estado_cobro_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("cita_id")}
  scope :fecha, -> { order("fecha_cita")}
  
  
end