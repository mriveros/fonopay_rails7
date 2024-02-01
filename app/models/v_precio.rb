class VPrecio < ActiveRecord::Base
  
  self.table_name= "v_precios"
  self.primary_key = "id"
  scope :orden_01, -> { order("id")}
  scope :precio_detalle, -> { select( "id, descripcion || '-' || monto  as precio")} 
 

end
