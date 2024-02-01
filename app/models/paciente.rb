class Paciente < ActiveRecord::Base

  self.table_name="pacientes"
  self.primary_key="id"
  extend Dragonfly::Model
  dragonfly_accessor :avatar
  include Avatarable
  attr_accessor :avatar_size

  dragonfly_accessor :avatar

  #attr_accessible :id, :nombres, :apellidos, :ci, :direccion, :telefono, :fecha_nacimiento
  
  scope :orden_01, -> { order("id")}
  scope :orden_nombres, -> { order("nombres, apellidos")}

  def full_name
    
    [nombres, apellidos].join(' ')
  
  end

  # required for avatarable
  def avatar_text
  
    nombres.chr
  
  end

  def avatar_size

    '150x150'

  end
  
end