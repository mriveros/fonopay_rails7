module RegistrosCobrosHelper

	def link_to_notificar_pago_pendiente(cita_id)

    	render partial: 'link_to_notificar_pago_pendiente', locals: { cita_id: cita_id }
    
	end


end