class Usuario < ActiveRecord::Base

  scope :ordenado_id, -> {order("id")}

  acts_as_authentic do |c|
    #c.act_like_restful_authentication = true
    #c.validate_email_field = false
    #password_length_constraints = c.validates_length_of_password_field_options.reject { |k,v| [:minimum, :maximum].include?(k) }
    #c.validates_length_of_password_field_options = password_length_constraints.merge :within => 5..24, :message => "Ingresar entre 5 a 24 caracteres."
    Authlogic::CryptoProviders::Sha1.stretches = 1
    ::REST_AUTH_SITE_KEY = '61a4ba65541a9c8ebbd2a70dc7487b8cea9dbcf0'
    c.crypto_provider = Authlogic::CryptoProviders::Sha1
   end

  has_many :perfiles, :dependent => :restrict_with_error
  belongs_to :persona
  belongs_to :perfil_actual, class_name: "Perfil", foreign_key: 'perfil_actual_id'  
  before_create -> {self.token = generate_token}

  def self.generar_password
  
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
    aux_pass = ''
    6.times { aux_pass << chars[rand(chars.size)] }
    aux_pass
  
  end

   def usuario_email
     
    usuario = Usuario.where("persona_id = ?", self.id).first 
    usuario.present? ? usuario.email : nil

  end

  private
  def generate_token
      loop do
        token = SecureRandom.hex
        return token unless Usuario.exists?({token: token})
      end
  end

end
