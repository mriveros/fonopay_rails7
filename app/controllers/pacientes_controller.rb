class PacientesController < ApplicationController

before_action :require_usuario
#skip_before_action :verify_authenticity_token
extend Dragonfly::Model
dragonfly_accessor :avatar

  def index
   
  end 

  def lista

    cond = []
    args = []

    if params[:form_buscar_pacientes_id].present?

      cond << "paciente_id = ?"
      args << params[:form_buscar_pacientes_id]

    end

    if params[:form_buscar_pacientes_nombre].present?

      cond << "nombres ilike ?"
      args << "%#{params[:form_buscar_pacientes_nombre]}%"

    end

    if params[:form_buscar_pacientes_apellido].present?

      cond << "apellidos ilike ?"
      args << "%#{params[:form_buscar_pacientes_apellido]}%"

    end

    if params[:form_buscar_pacientes_ci].present?

      cond << "ci = ?"
      args << params[:form_buscar_pacientes_ci]

    end

    if params[:form_buscar_pacientes_fecha_nacimiento].present?

      cond << "fecha_nacimiento = ?"
      args << params[:form_buscar_pacientes_fecha_nacimiento]

    end

    if params[:form_buscar_pacientes_direccion].present?

      cond << "direccion ilike ?"
      args << "%#{params[:form_buscar_pacientes_direccion]}%"

    end

    if params[:form_buscar_pacientes_telefono_contacto].present?

      cond << "telefono_contacto ilike ?"
      args << "%#{params[:form_buscar_pacientes_telefono_contacto]}%"

    end

    if params[:form_buscar_pacientes_email_contacto].present?

      cond << "email_contacto ilike ?"
      args << "%#{params[:form_buscar_pacientes_email_contacto]}%"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @pacientes =  VPaciente.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VPaciente.where(cond).count
      
    else

      @pacientes = VPaciente.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VPaciente.count

    end

    @total_registros = VPaciente.count

  	respond_to do |f|
	    
	   f.js
	    
	  end

  end

  def agregar

    @paciente = Paciente.new

    respond_to do |f|
	    
	      f.js
	    
	  end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false
    

    if @valido
      
      @paciente = Paciente.new()
      @paciente.nombres = params[:nombres].upcase
      @paciente.apellidos = params[:apellidos].upcase
      @paciente.ci = params[:ci]
      @paciente.fecha_nacimiento = params[:paciente][:fecha_nacimiento]
      @paciente.direccion = params[:direccion].upcase
      @paciente.telefono = params[:telefono]
      @paciente.email = params[:email]
      @paciente.avatar = params[:paciente][:photo]

        if @paciente.save

          auditoria_nueva("registrar paciente", "pacientes", @paciente)
          @guardado_ok = true
          @persona = Persona.where('documento_persona = ?', params[:ci]).first
          
          unless @persona.present?

            @persona = Persona.new
            @persona.nombre_persona = params[:nombres].upcase
            @persona.apellido_persona = params[:apellidos].upcase
            @persona.documento_persona = params[:ci]
            @persona.tipo_documento_id = params[:persona][:tipo_documento_id]
            @persona.nacionalidad_id = params[:persona][:nacionalidad_id]
            @persona.fecha_nacimiento = params[:paciente][:fecha_nacimiento]
            @persona.direccion = params[:direccion].upcase
            @persona.telefono = params[:telefono]
            @persona.celular = params[:telefono]
            #sexo por defecto no especificado
            @persona.genero_id = 3 
            if @persona.save
              @guardado_ok = true
               auditoria_nueva("registrar persona", "personas", @persona)
            end

          end
         
        end 
 
    end
  
    rescue Exception => exc  
    # dispone el mensaje de error 
    #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep.to_s
      end                
              
  	respond_to do |f|
	    
	      f.js
	    
	   end

  end

  def editar

    @paciente = Paciente.find(params[:paciente_id])

  	respond_to do |f|
	    
	      f.js
	    
	end

  end

  def actualizar

    valido = true
    @msg = ""

    @paciente = Paciente.find(params[:paciente_id])

    auditoria_id = auditoria_antes("actualizar paciente", "pacientes", @paciente)

    if valido

      @paciente.nombres = params[:paciente][:nombres].upcase
      @paciente.apellidos = params[:paciente][:apellidos].upcase
      @paciente.ci = params[:paciente][:ci]
      @paciente.fecha_nacimiento = params[:paciente][:fecha_nacimiento]
      @paciente.direccion = params[:paciente][:direccion].upcase
      @paciente.telefono = params[:paciente][:telefono]
      @paciente.email = params[:paciente][:email]
      puts 'ANTES??????????'
      @paciente.avatar = params[:paciente][:photo]
      puts 'DESPUES@@@@@@@@@@@@@@@@@'
      if @paciente.save

        auditoria_despues(@paciente, auditoria_id)
        @paciente_ok = true

      end

    end
    rescue Exception => exc  
      # dispone el mensaje de error 
      puts "Aqui si muestra el error: ".concat(exc.message)
      if exc.present?        
      
        @excep = exc.message.split(':')    
        @msg = @excep[3]
      
      end                

  	respond_to do |f|
	    
	      f.js
	    
	  end

  end

  def buscar_paciente
    
    @pacientes = Paciente.where("nombres ilike ?", "%#{params[:paciente]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @pacientes }
    
    end
    
  end

  def buscar_persona
    
    if params[:tipo_documento_id].present? && params[:nacionalidad_id] && params[:documento].present?

      @persona = Persona.where("tipo_documento_id = ? and nacionalidad_id = ? and documento_persona = ?", params[:tipo_documento_id], params[:nacionalidad_id], params[:documento])  

    end

    respond_to do |f|
      f.json { render :json => @persona.first}
    end

  end

  def eliminar

    valido = true
    @msg = ""

    @paciente = Paciente.find(params[:paciente_id])

    @paciente_elim = @paciente  

    if valido

      if @paciente.destroy

        auditoria_nueva("eliminar paciente", "pacientes", @paciente_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el paciente."

      end

    end
        rescue Exception => exc  
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @eliminado = false
        end
        
    respond_to do |f|

      f.js

    end

  end

  def buscar_paciente_documento
    
    puts "*************************DEBUG!!!"
    
    if params[:documento].present?

      @paciente = Paciente.where("ci = ?", params[:documento])

    end

    respond_to do |f|

      f.json { render :json => @paciente.first}
    
    end

  end

end