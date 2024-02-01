class PagoConsulta < ActiveRecord::Base

  self.table_name="pagos_consultas"
  self.primary_key="id"
  
  #attr_accessible :id, :fecha_cita, :paciente_id, :boleta_pago, :mes_periodo_id, :anho_id, :sucursal_id, :monto, :estado_pago_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end