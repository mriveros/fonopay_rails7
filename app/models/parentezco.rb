class Parentezco < ActiveRecord::Base

  self.table_name="parentescos"
  self.primary_key="id"
  
  scope :orden_01, -> { order("id")}
  
end