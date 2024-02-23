class Auditoria < ActiveRecord::Base

    self.table_name="auditorias_01_2024"  	    
    establish_connection :DB_AUDITORIAS 
  	
end