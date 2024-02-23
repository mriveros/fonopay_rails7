class Accion < ActiveRecord::Base

  scope :orden_id, -> {order("id")}

  belongs_to :controlador

  has_many :accesos, :dependent => :restrict_with_error

end