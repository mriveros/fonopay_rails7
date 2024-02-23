class Localidad < ActiveRecord::Base

  scope :orden_descripcion, -> { order('descripcion')}

  belongs_to :jurisdicion

  has_many :personas, :dependent => :restrict_with_error

end
