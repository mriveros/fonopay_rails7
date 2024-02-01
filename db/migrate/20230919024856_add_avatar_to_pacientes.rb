class AddAvatarToPacientes < ActiveRecord::Migration
  
  def change

    add_column :pacientes, :avatar_uid, :string
    add_column :pacientes, :avatar_name, :string
  
  end

end
