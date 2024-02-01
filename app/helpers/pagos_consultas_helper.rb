module PagosConsultasHelper

	def link_to_pago_consulta_detalle(pago_consulta_id)

      render partial: 'link_to_pago_consulta_detalle', locals: { pago_consulta_id: pago_consulta_id }
      
  	end

  	def link_to_pago_pago_consulta_detalle(pago_consulta_detalle_id)

      render partial: 'link_to_pago_pago_consulta_detalle', locals: { pago_consulta_detalle_id: pago_consulta_detalle_id }
      
  	end

    def link_to_notificar_pago_consulta_detalle_pendiente(pago_consulta_detalle_id)

      render partial: 'link_to_notificar_pago_consulta_detalle_pendiente', locals: { pago_consulta_detalle_id: pago_consulta_detalle_id }
      
    end

end