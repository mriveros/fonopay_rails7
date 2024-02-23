class Perfil < ActiveRecord::Base

  has_many :usuarios, foreign_key: 'perfil_actual_id', :dependent => :restrict_with_error

  belongs_to :rol
  belongs_to :usuario

end
