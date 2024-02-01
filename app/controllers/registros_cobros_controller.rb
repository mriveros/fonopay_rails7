class RegistrosCobrosController < ApplicationController

before_action :require_usuario
#skip_before_action :verify_authenticity_token

  def index

  end

  def lista

    cond = [] 
    args = []

    if params[:form_buscar_cobros_consultas_id].present?
 
      cond << "cita_id = ?"
      args << params[:form_buscar_cobros_consultas_id]

    end


    if params[:form_buscar_cobros_consultas_fecha_cita].present?
 
      cond << "fecha_cita = ?"
      args << params[:form_buscar_cobros_consultas_fecha_cita]

    end

    if params[:form_buscar_cobros_consultas_paciente_documento].present?
 
      cond << "paciente_documento = ?"
      args << params[:form_buscar_cobros_consultas_paciente_documento]

    end

    if params[:form_buscar_cobros_consultas_paciente_nombres].present?
 
      cond << "paciente_documento ilike ?"
      args << "%#{params[:form_buscar_cobros_consultas_paciente_nombres]}%"

    end

    if params[:form_buscar_cobros_consultas][:mes_id].present?
 
      cond << "mes = ?"
      args << params[:form_buscar_cobros_consultas][:mes_id]

    end

    if params[:form_buscar_cobros_consultas][:anho_id].present?
 
      cond << "anho = ?"
      args << params[:form_buscar_cobros_consultas][:anho_id]

    end

    if params[:form_buscar_cobros_consultas][:profesional_id].present?
 
      cond << "profesional_id = ?"
      args << params[:form_buscar_cobros_consultas][:profesional_id]

    end

    if params[:form_buscar_cobros_consultas_monto].present?
 
      cond << "precio = ?"
      args << params[:form_buscar_cobros_consultas_monto]

    end

    if params[:form_buscar_cobros_consultas][:estado_cobro_id].present?
 
      cond << "estado_cobro_id = ?"
      args << params[:form_buscar_cobros_consultas][:estado_cobro_id]

    end


    

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @citas =  VRegistroCobro.fecha.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VRegistroCobro.where(cond).count
      
    else

      @citas = VRegistroCobro.fecha.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VRegistroCobro.count

    end

    @total_registros = VRegistroCobro.count

    respond_to do |f|
      
      f.js
      
    end

  end 


  def cobrar_consulta

    
    @cobrar_consulta = CobroConsulta.where("id = ?", params[:cobro_consulta_id]).first
    @cita = Cita.where("id = ?", @cobrar_consulta.cita_id ).first

    respond_to do |f|

      f.js

    end

  end


  def guardar_cobro_consulta

    @valido = true
    @msg = ""
    @guardado_ok = false

    @cuota_detalle = CuotaDetalle.where("id = ?", params[:cuota_detalle_id]).first
    @cuota_detalle.pago_cuota = params[:monto_pago]
    @cuota_detalle.estado_pago_cuota_detalle_id = PARAMETRO[:estado_pago_cuota_detalle_pagado]
    @cuota_detalle.fecha_pago = params[:fecha_pago]
    @cuota_detalle.numero_comprobante = params[:numero_comprobante]

    if @cuota_detalle.save

       @cuota = Cuota.where('id = ?', @cuota_detalle.cuota_id).first
       @cuota.total_cobradas = CuotaDetalle.where("cuota_id = ?", @cuota_detalle.cuota_id).sum(:pago_cuota)
       @cuota.save
     @guardado_ok = true;

    end

    #ENVIAR NOTIFICACION DE PAGO
    @enviado = false
    alumno = Alumno.where('id = ?', @cuota_detalle.alumno_id).first
    @subject = 'Aviso de Pago de Cuota.'
    @texto = 'Pago de cuota procesado exitosamente.'

    if alumno.email.present?
      
      NotificarUsuario.enviar_notificacion(alumno.email, @subject, @texto, params[:cuota_detalle_id]).deliver

    end

    respond_to do |f|

      f.js

    end

  end

  def cambiar_estado_cobro_a_cobrado

    @msg = ""
    @actualizado = false
    
    @cita = Cita.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("cambiar estado de cobro de cita a cobrado", "citas", @cita)

    if @cita.present?

      @cita.estado_cobro_id = PARAMETRO[:estado_cobro_cobrado]
      @cita.estado_cita_id = PARAMETRO[:estado_cita_finalizado]

      if @cita.save
      
        @msg = "La Cita ha sido marcado como Cobrado exitosamente!"
        @actualizado = true
        auditoria_despues(@cita, auditoria_id)

        registro_cobro = RegistroCobro.where('cita_id = ?', @cita.id).first
        registro_cobro.estado_cobro_id =  @cita.estado_cita_id
        registro_cobro.save

      end

    else

      @msg = "No se pudo realizar la modificación del estado de cobro de la Cita. Intente más tarde."

    end
    
    rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat( " " + @excep[4].to_s)
        @actualizado = false
        
    end

    respond_to do |f|

      f.js

    end

  end


  def cambiar_estado_cobro_a_no_cobrado

    @msg = ""
    @actualizado = false
    
    @cita = Cita.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("cambiar estado de cobro de cita a cobrado", "citas", @cita)

    if @cita.present?

      @cita.estado_cobro_id = PARAMETRO[:estado_cobro_no_cobrado]
      @cita.estado_cita_id = PARAMETRO[:estado_cita_pendiente]

      if @cita.save
      
        @msg = "La Cita ha sido marcado como No Cobrado"
        @actualizado = true
        auditoria_despues(@cita, auditoria_id)
        registro_cobro = RegistroCobro.where('cita_id = ?', @cita.id).first
        registro_cobro.estado_cobro_id =  @cita.estado_cita_id
        registro_cobro.save

      end

    else

      @msg = "No se pudo realizar la modificación del estado de cobro de la Cita. Intente más tarde."

    end
    
    rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat( " " + @excep[4].to_s)
        @actualizado = false
        
    end

    respond_to do |f|

      f.js

    end

  end
  

  def notificar_pago_pendiente
    
    @enviado = false
    @cita = VCita.where('cita_id = ?', params[:cita_id]).first
    paciente = Paciente.where('id = ?', @cita.paciente_id).first

    @subject = 'Aviso de Citas Pendientes de Pago.'
    @texto = 'Cuenta con citas pendientes de pago.'
    if paciente.email.present?
      
      NotificarUsuario.enviar_notificacion(paciente.email, @subject, @texto, @cita.paciente_id).deliver
      @enviado = true;

    else
      
      @enviado = false

    end

  end

end