class AreaAcademica < ActiveRecord::Base

  self.table_name="areas_academicas"
  
  scope :orden_id, -> {order("id")}

  has_many :materiales_educativos, class_name: "MaterialEducativo"
  
end
