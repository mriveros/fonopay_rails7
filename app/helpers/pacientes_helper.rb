module PacientesHelper

	def link_to_editar_paciente(paciente_id)
		
	    render partial: 'link_to_editar_paciente', locals: { paciente_id: paciente_id }
	    
	end

	def paciente_avatar(paciente, options = {})

    if paciente.avatar.present?
      
      image_tag paciente.avatar_url, options
    
    else
    
      #image_tag paciente.photo.thumb('150x150#').url, options
      image_tag paciente.avatar_url, options

    end
  
  end
  
end