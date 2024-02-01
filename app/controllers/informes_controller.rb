class InformesController < ApplicationController

	before_action :require_usuario

  def indexa

  	cond = []
    args = []

  	@informe = "informes"
  	@msg = "" 
    
    if params[:v_paciente_id].present?

      cond << "paciente_id = ?"
      args << params[:v_paciente_id]

    end

    if params[:profesional][:id].present?
 
      cond << "profesional_id = ?"
      args << params[:profesional][:id]

    end

    if params[:estado_cobro][:id].present?

      cond << "estado_cobro_id = ?"
      args << params[:estado_cobro][:id]

    end

    if params[:fecha_desde].present? && params[:fecha_hasta].present? 

      cond << "fecha_cita >= '#{params[:fecha_desde]}' and fecha_cita <= '#{params[:fecha_hasta]}'" 

    elsif params[:fecha_desde].present?
      
      cond << "fecha_cita >= ?"
      args << params[:fecha_desde]

    elsif params[:fecha_hasta].present?
      
      cond << "fecha_cita <= ?"
      args << params[:fecha_hasta]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0
     
      @cuota_detalle =  VRegistroCobro.where(cond).orden_01.paginate(per_page: 10, page: params[:page])

    else

      @cuota_detalle = VRegistroCobro.orden_01.paginate(per_page: 10, page: params[:page])

    end

    @parametros = { format: :pdf, cita_id: @cuota_detalle.map(&:cita_id), paciente_id: params[:v_paciente_id], profesional_id: params[:profesional][:id], estado_cobro_id: params[:estado_cobro][:id], fecha_desde: params[:fecha_desde], fecha_hasta: params[:fecha_hasta] }

    respond_to do |f|

      f.js

    end

  end

  def generar_pdf
    
    
   @registros_cobros =  VRegistroCobro.where("cita_id in (?)", params[:cita_id]).orden_01.paginate(per_page: 10, page: params[:page])
    

    respond_to do |f|
     
      f.pdf do

          render  :pdf => "planilla_resumen_cuotas_#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'informes/planilla_reporte_cuotas.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "informes/cabecera_planilla_resumen_cuotas.pdf.erb" ,
                  :locals   => { :cuota => @registros_cobros }}},
                  :margin => {:top => 65,                         # default 10 (mm)
                  :bottom => 11,
                  :left => 3,
                  :right => 3},
                  :orientation => 'Landscape',
                  :page_size => "A4",
                  :footer => { :html => {:template => 'layouts/footer.pdf' },
                  :spacing => 1,
                  :line => true }
      end
      
    end

  end

end


