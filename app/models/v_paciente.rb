class VPaciente < ActiveRecord::Base

  self.table_name="v_pacientes"
  self.primary_key="paciente_id"
  
  extend Dragonfly::Model
  dragonfly_accessor :avatar
  include Avatarable

  #attr_accessible :id, :nombres, :apellidos, :ci, :direccion, :telefono, :fecha_nacimiento
  
  scope :orden_01, -> { order("paciente_id")}
  scope :orden_nombres, -> { order("nombres, apellidos")}
  
  def full_name
  
    [nombres, apellidos].join(' ')
  
  end

  # required for avatarable
  def avatar_text
  
    nombres.chr
  
  end
  
end