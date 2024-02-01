# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20230919024856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesos", force: true do |t|
    t.integer  "rol_id",     null: false
    t.integer  "accion_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accesos", ["accion_id"], name: "accesos_accion_id_idx", using: :btree
  add_index "accesos", ["rol_id", "accion_id"], name: "accesos_uniq_01", unique: true, using: :btree
  add_index "accesos", ["rol_id"], name: "accesos_rol_id_idx", using: :btree

  create_table "acciones", force: true do |t|
    t.string   "descripcion",    null: false
    t.integer  "controlador_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "acciones", ["controlador_id", "descripcion"], name: "acciones_uniq_01", unique: true, using: :btree
  add_index "acciones", ["controlador_id"], name: "acciones_controlador_id_idx", using: :btree
  add_index "acciones", ["descripcion"], name: "acciones_descripcion_idx", using: :btree

  create_table "cargos", force: true do |t|
    t.string   "descripcion",                          null: false
    t.decimal  "sueldo",      precision: 12, scale: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cargos", ["descripcion"], name: "cargos_un", unique: true, using: :btree

  create_table "citas", force: true do |t|
    t.datetime "fecha_cita",       null: false
    t.integer  "paciente_id",      null: false
    t.integer  "profesional_id",   null: false
    t.integer  "tipo_consulta_id", null: false
    t.integer  "especialidad_id",  null: false
    t.integer  "precio_id",        null: false
    t.string   "observacion"
    t.integer  "estado_cita_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estado_cobro_id",  null: false
  end

  create_table "controladores", force: true do |t|
    t.string   "descripcion", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "controladores", ["descripcion"], name: "controladores_descripcion_idx", using: :btree
  add_index "controladores", ["descripcion"], name: "uniq_controladores_01", unique: true, using: :btree

  create_table "cuotas", force: true do |t|
    t.datetime "fecha_generacion",                            null: false
    t.integer  "mes_periodo_id",                              null: false
    t.integer  "periodo_escolar_id",                          null: false
    t.decimal  "total_cuotas",       precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "total_cobradas",     precision: 10, scale: 0
    t.integer  "matriculacion_id",                            null: false
  end

  create_table "cuotas_detalles", force: true do |t|
    t.integer  "cuota_id",                                                          null: false
    t.integer  "alumno_id",                                                         null: false
    t.decimal  "monto_cuota",                              precision: 10, scale: 0, null: false
    t.decimal  "pago_cuota",                               precision: 10, scale: 0
    t.integer  "estado_pago_cuota_detalle_id",                                      null: false
    t.datetime "fecha_pago"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "numero_comprobante"
    t.string   "observacion",                  limit: 510
  end

  create_table "departamentos", force: true do |t|
    t.string   "descripcion",                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pais_id",                                       null: false
    t.boolean  "estado",                         default: true, null: false
    t.integer  "division_politica_id"
    t.string   "codigo_departamento",  limit: 4,                null: false
    t.integer  "orden"
  end

  add_index "departamentos", ["codigo_departamento"], name: "departamentos_codigo_key", unique: true, using: :btree
  add_index "departamentos", ["descripcion"], name: "departamentos_descripcion_idx", using: :btree
  add_index "departamentos", ["descripcion"], name: "departamentos_descripcion_key", unique: true, using: :btree
  add_index "departamentos", ["pais_id"], name: "departamentos_pais_id_idx", using: :btree

  create_table "detalles_debitos", force: true do |t|
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dias", force: true do |t|
    t.string "dia", limit: 30, null: false
  end

  add_index "dias", ["dia"], name: "dias_dia_key", unique: true, using: :btree

  create_table "disciplinas", force: true do |t|
    t.string   "descripcion",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codigo_sigmec",       limit: 50
    t.integer  "codigo_nautilus"
    t.string   "descripcion_guarani"
    t.integer  "codigo_nautilus2"
  end

  add_index "disciplinas", ["descripcion"], name: "disciplinas_descripcion_key", unique: true, using: :btree

  create_table "divisiones_politicas", force: true do |t|
    t.string   "descripcion",                null: false
    t.boolean  "estado",      default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "divisiones_politicas", ["descripcion"], name: "divisiones_politicas_descripcion_idx", using: :btree
  add_index "divisiones_politicas", ["descripcion"], name: "divisiones_politicas_descripcion_key", unique: true, using: :btree

  create_table "especialidades", force: true do |t|
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "especialidades", ["descripcion"], name: "especialidades_descripcion_key", unique: true, using: :btree

  create_table "estados_citas", force: true do |t|
    t.string   "descripcion",     null: false
    t.integer  "especialidad_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados_citas", ["descripcion"], name: "estados_citas_descripcion_key", unique: true, using: :btree

  create_table "estados_civiles", force: true do |t|
    t.string   "descripcion", limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados_civiles", ["descripcion"], name: "estados_civiles_descripcion_idx", using: :btree
  add_index "estados_civiles", ["descripcion"], name: "estados_civiles_descripcion_key", unique: true, using: :btree

  create_table "estados_cobros", force: true do |t|
    t.string   "descripcion", limit: nil
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados_cobros", ["descripcion"], name: "estados_cobros_descripcion_key", unique: true, using: :btree

  create_table "estados_matriculaciones", force: true do |t|
    t.string   "descripcion", limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados_matriculaciones", ["descripcion"], name: "estados_matriculaciones_descripcion_key", unique: true, using: :btree

  create_table "estados_matriculaciones_detalles", force: true do |t|
    t.string   "descripcion", limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados_matriculaciones_detalles", ["descripcion"], name: "estados_matriculaciones_detalles_descripcion_key", unique: true, using: :btree

  create_table "estados_personales", force: true do |t|
    t.string   "descripcion", limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados_personales", ["descripcion"], name: "estados_personales_un", unique: true, using: :btree

  create_table "generos", force: true do |t|
    t.integer  "codigo",      null: false
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "generos", ["codigo"], name: "generos_codigo_idx", using: :btree
  add_index "generos", ["codigo"], name: "generos_codigo_key", unique: true, using: :btree
  add_index "generos", ["descripcion"], name: "generos_descripcion_idx", using: :btree
  add_index "generos", ["descripcion"], name: "generos_descripcion_key", unique: true, using: :btree

  create_table "haciendas", force: true do |t|
    t.string  "descripcion",                 null: false
    t.string  "posicion_x",      limit: 15
    t.string  "posicion_y",      limit: 15
    t.integer "departamento_id",             null: false
    t.time    "created_at"
    t.time    "updated_at"
    t.string  "observacion",     limit: 510
    t.integer "jurisdiccion_id",             null: false
  end

  add_index "haciendas", ["descripcion"], name: "haciendas_descripcion_key", unique: true, using: :btree

  create_table "informaciones", force: true do |t|
    t.string   "titulo",                limit: 100,                    null: false
    t.string   "contenido",             limit: 1000,                   null: false
    t.date     "fecha_publicacion",                                    null: false
    t.date     "fecha_fin_publicacion"
    t.integer  "usuario_id",                                           null: false
    t.datetime "created_at",                         default: "now()", null: false
    t.datetime "updated_at"
  end

  add_index "informaciones", ["contenido"], name: "ix_informaciones_001", using: :btree
  add_index "informaciones", ["usuario_id"], name: "ix_informaciones_002", using: :btree

  create_table "informaciones_enlaces", force: true do |t|
    t.string   "titulo",         limit: 100,                   null: false
    t.string   "enlace",                                       null: false
    t.integer  "informacion_id",                               null: false
    t.datetime "created_at",                 default: "now()", null: false
    t.datetime "updated_at"
  end

  add_index "informaciones_enlaces", ["enlace"], name: "ix_informaciones_enlaces_001", using: :btree
  add_index "informaciones_enlaces", ["informacion_id"], name: "ix_informaciones_enlaces_002", using: :btree

  create_table "informaciones_roles", force: true do |t|
    t.integer  "informacion_id",                   null: false
    t.integer  "rol_id",                           null: false
    t.datetime "created_at",     default: "now()", null: false
    t.datetime "updated_at"
  end

  add_index "informaciones_roles", ["informacion_id", "rol_id"], name: "uq_informaciones_roles_001", using: :btree
  add_index "informaciones_roles", ["informacion_id"], name: "ix_informaciones_roles_001", using: :btree
  add_index "informaciones_roles", ["rol_id"], name: "ix_informaciones_roles_002", using: :btree

  create_table "jurisdicciones", force: true do |t|
    t.integer "departamento_id"
    t.string  "descripcion",                              null: false
    t.string  "address"
    t.float   "latitude"
    t.float   "longitude"
    t.boolean "gmaps"
    t.boolean "estado",                    default: true
    t.string  "codigo_distrito", limit: 4
  end

  add_index "jurisdicciones", ["departamento_id"], name: "jurisdicciones_departamento_id_idx", using: :btree
  add_index "jurisdicciones", ["descripcion"], name: "jurisdicciones_descripcion_idx", using: :btree

  create_table "localidades", force: true do |t|
    t.string    "descripcion",                               null: false
    t.integer   "jurisdiccion_id",                           null: false
    t.timestamp "created_at",                  precision: 0
    t.datetime  "updated_at"
    t.string    "codigo",          limit: nil
  end

  add_index "localidades", ["descripcion"], name: "localidades_descripcion_idx", using: :btree
  add_index "localidades", ["jurisdiccion_id"], name: "localidades_jurisdiccion_id_idx", using: :btree

  create_table "matriculaciones", force: true do |t|
    t.integer  "nivel_id",                null: false
    t.integer  "sala_id",                 null: false
    t.integer  "periodo_escolar_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estado_matriculacion_id", null: false
    t.integer  "sucursal_id",             null: false
  end

  create_table "matriculaciones_detalles", force: true do |t|
    t.integer  "matriculacion_id",                null: false
    t.integer  "alumno_id",                       null: false
    t.integer  "precio_id",                       null: false
    t.time     "fecha_matriculacion"
    t.integer  "estado_matriculacion_detalle_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meses", force: true do |t|
    t.integer  "mes",         null: false
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meses", ["descripcion"], name: "meses_descripcion_key", unique: true, using: :btree
  add_index "meses", ["mes"], name: "meses_mes_key", unique: true, using: :btree

  create_table "metodos_pagos", force: true do |t|
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nacionalidades", force: true do |t|
    t.integer  "codigo"
    t.string   "pais",        limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "descripcion", limit: nil
  end

  add_index "nacionalidades", ["codigo"], name: "nacionalidades_codigo_key", unique: true, using: :btree
  add_index "nacionalidades", ["descripcion"], name: "nacionalidades_descripcion_key1", unique: true, using: :btree
  add_index "nacionalidades", ["pais"], name: "nacionalidades_descripcion_key", unique: true, using: :btree

  create_table "niveles", id: false, force: true do |t|
    t.integer  "id",          null: false
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "niveles", ["descripcion"], name: "cursos_descripcion_idx", using: :btree
  add_index "niveles", ["descripcion"], name: "cursos_descripcion_key", unique: true, using: :btree

  create_table "pacientes", force: true do |t|
    t.string    "nombres",                                    null: false
    t.string    "apellidos",                                  null: false
    t.string    "ci",               limit: 10,                null: false
    t.timestamp "fecha_nacimiento",             precision: 0, null: false
    t.string    "direccion",        limit: 510
    t.string    "telefono",         limit: 12
    t.string    "image_url",        limit: nil
    t.string    "photo_uid",        limit: 510
    t.timestamp "created_at",                   precision: 0
    t.timestamp "updated_at",                   precision: 0
    t.string    "email",            limit: nil
    t.string    "avatar_uid"
    t.string    "avatar_name"
  end

  create_table "pagos_adelantos", force: true do |t|
    t.datetime "fecha",                                                   null: false
    t.integer  "personal_id",                                             null: false
    t.decimal  "monto",                          precision: 12, scale: 0, null: false
    t.integer  "mes_periodo_id",                                          null: false
    t.integer  "periodo_escolar_id",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "observacion",        limit: 510
  end

  create_table "pagos_descuentos", force: true do |t|
    t.datetime "fecha",                                                   null: false
    t.integer  "personal_id",                                             null: false
    t.decimal  "monto",                          precision: 12, scale: 0, null: false
    t.integer  "mes_periodo_id",                                          null: false
    t.integer  "periodo_escolar_id",                                      null: false
    t.string   "observacion",        limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pagos_remuneraciones_extras", force: true do |t|
    t.datetime "fecha",                                                   null: false
    t.integer  "personal_id",                                             null: false
    t.decimal  "monto",                          precision: 12, scale: 0, null: false
    t.integer  "mes_periodo_id",                                          null: false
    t.integer  "periodo_escolar_id",                                      null: false
    t.string   "observacion",        limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pagos_salarios", force: true do |t|
    t.datetime "fecha",                                                            null: false
    t.integer  "mes_periodo_id"
    t.integer  "periodo_escolar_id",                                               null: false
    t.integer  "sucursal_id",                                                      null: false
    t.decimal  "total_salario",               precision: 10, scale: 0, default: 0, null: false
    t.decimal  "total_adelantos",             precision: 10, scale: 0, default: 0, null: false
    t.decimal  "total_descuentos",            precision: 10, scale: 0, default: 0, null: false
    t.decimal  "total_remuneraciones_extras", precision: 10, scale: 0, default: 0, null: false
    t.decimal  "monto_total_pagado",          precision: 10, scale: 0, default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pagos_salarios_detalles", force: true do |t|
    t.integer  "pago_salario_id",                                           null: false
    t.integer  "personal_id",                                               null: false
    t.integer  "cargo_id",                                                  null: false
    t.decimal  "salario_base",         precision: 10, scale: 0,             null: false
    t.decimal  "adelantos",            precision: 10, scale: 0, default: 0, null: false
    t.decimal  "descuentos",           precision: 10, scale: 0, default: 0, null: false
    t.decimal  "otras_remuneraciones", precision: 10, scale: 0, default: 0, null: false
    t.decimal  "salario_percibido",    precision: 10, scale: 0,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paises", force: true do |t|
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "codigo",      null: false
  end

  add_index "paises", ["codigo"], name: "paises_codigo_key", unique: true, using: :btree
  add_index "paises", ["descripcion"], name: "paises_descripcion_key", unique: true, using: :btree

  create_table "parentescos", force: true do |t|
    t.string   "descripcion"
    t.time     "created_at"
    t.datetime "updated_at"
  end

  add_index "parentescos", ["descripcion"], name: "parentezcos_descripcion_key", unique: true, using: :btree

  create_table "perfiles", force: true do |t|
    t.integer  "usuario_id", null: false
    t.integer  "rol_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "perfiles", ["rol_id", "usuario_id"], name: "uniq_perfiles_01", unique: true, using: :btree

  create_table "periodos_escolares", id: false, force: true do |t|
    t.integer  "id",           null: false
    t.string   "anho_periodo", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "periodos_escolares", ["anho_periodo"], name: "periodo_escolar_anho_periodo_key", unique: true, using: :btree
  add_index "periodos_escolares", ["anho_periodo"], name: "periodos_escolares_descripcion_idx", using: :btree

  create_table "personales", force: true do |t|
    t.string   "nombre",                         null: false
    t.string   "apellido",                       null: false
    t.string   "ruc_ci",             limit: 15,  null: false
    t.string   "direccion"
    t.string   "telefono",           limit: 20
    t.string   "email",              limit: 50
    t.integer  "cargo_id",                       null: false
    t.string   "observacion",        limit: 512
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sucursal_id"
    t.integer  "estado_personal_id",             null: false
  end

  create_table "personas", force: true do |t|
    t.string   "documento_persona",          limit: 50
    t.string   "nombre_persona",             limit: 100, null: false
    t.string   "apellido_persona",           limit: 100, null: false
    t.integer  "tipo_documento_id",                      null: false
    t.integer  "genero_id",                              null: false
    t.date     "fecha_nacimiento",                       null: false
    t.integer  "nacionalidad_id"
    t.string   "numero_oficina",             limit: 10
    t.date     "fecha_inscripcion"
    t.string   "folio",                      limit: 10
    t.string   "libro",                      limit: 10
    t.string   "acta",                       limit: 10
    t.string   "direccion",                  limit: 200
    t.integer  "jurisdiccion_id"
    t.integer  "localidad_id"
    t.integer  "numero_casa"
    t.string   "nombre_edificio",            limit: 100
    t.string   "numero_apartamento",         limit: 10
    t.string   "telefono",                   limit: 30
    t.string   "celular",                    limit: 30
    t.string   "correo_electronico",         limit: 50
    t.string   "carnet_indigena",            limit: 100
    t.integer  "estado_civil_id"
    t.integer  "comunidad_indigena_id"
    t.integer  "etnia_id"
    t.integer  "grupo_sanguineo_id"
    t.string   "lugar_nacimiento",           limit: 150
    t.string   "nacionalidad",               limit: nil
    t.string   "estado_civil",               limit: nil
    t.integer  "jurisdiccion_nacimiento_id"
    t.string   "barrio_localidad",           limit: 250
    t.string   "comunidad_indigena",         limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "primer_nombre_persona",      limit: 30
    t.string   "segundo_nombre_persona",     limit: 30
    t.string   "primer_apellido_persona",    limit: 30
    t.string   "segundo_apellido_persona",   limit: 30
    t.string   "apellido_casada_persona",    limit: 30
  end

  add_index "personas", ["apellido_persona"], name: "personas_apellido_persona_idx", using: :btree
  add_index "personas", ["documento_persona", "tipo_documento_id", "nacionalidad_id"], name: "uniq_personas_01", unique: true, using: :btree
  add_index "personas", ["documento_persona"], name: "personas_documento_persona_idx", using: :btree
  add_index "personas", ["id"], name: "personas_id_idx", using: :btree
  add_index "personas", ["nombre_persona", "apellido_persona", "fecha_nacimiento", "folio", "libro", "acta"], name: "uniq_personas_02", unique: true, using: :btree
  add_index "personas", ["nombre_persona"], name: "personas_nombre_persona_idx", using: :btree
  add_index "personas", ["tipo_documento_id"], name: "personas_tipo_documento_id_idx", using: :btree

  create_table "precios", force: true do |t|
    t.string   "codigo",         limit: 6,                                         null: false
    t.string   "descripcion",                                                      null: false
    t.decimal  "monto",                    precision: 8, scale: 0,                 null: false
    t.time     "created_at"
    t.datetime "updated_at"
    t.boolean  "predeterminado",                                   default: false
  end

  add_index "precios", ["codigo"], name: "precios_codigo_key", unique: true, using: :btree
  add_index "precios", ["descripcion"], name: "precios_descripcion_key", unique: true, using: :btree

  create_table "profesionales", force: true do |t|
    t.integer "persona_id", null: false
  end

  add_index "profesionales", ["persona_id"], name: "profesionales_persona_id_key", unique: true, using: :btree

  create_table "registros_cobros", force: true do |t|
    t.integer  "cita_id",         null: false
    t.datetime "fecha_cita",      null: false
    t.datetime "fecha_cobro",     null: false
    t.integer  "metodo_pago_id"
    t.integer  "estado_cobro_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "registros_gastos", force: true do |t|
    t.datetime "fecha",                                                null: false
    t.integer  "gasto_id",                                             null: false
    t.decimal  "monto",                       precision: 12, scale: 0, null: false
    t.string   "observacion",     limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pago_salario_id"
  end

  create_table "resoluciones", force: true do |t|
    t.string   "numero",             limit: 100,                 null: false
    t.string   "descripcion",                                    null: false
    t.date     "fecha_emision",                                  null: false
    t.integer  "tipo_resolucion_id",                             null: false
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.boolean  "habilitado",                     default: false, null: false
  end

  create_table "roles", force: true do |t|
    t.string    "descripcion", limit: 100,                           null: false
    t.timestamp "created_at",              precision: 0
    t.timestamp "updated_at",              precision: 0
    t.integer   "sistema_id",                            default: 1
  end

  add_index "roles", ["descripcion"], name: "roles_descripcion_key", unique: true, using: :btree

  create_table "salas", id: false, force: true do |t|
    t.integer  "id",          null: false
    t.string   "descripcion", null: false
    t.string   "color",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sistemas", force: true do |t|
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sistemas", ["descripcion"], name: "sistemas_descripcion_key", unique: true, using: :btree

  create_table "sucursales", force: true do |t|
    t.string  "descripcion",                 null: false
    t.integer "departamento_id",             null: false
    t.string  "observacion",     limit: 510
    t.integer "jurisdiccion_id",             null: false
    t.time    "created_at"
    t.time    "updated_at"
  end

  add_index "sucursales", ["descripcion"], name: "sucursales_descripcion_key", unique: true, using: :btree

  create_table "tipos_consultas", force: true do |t|
    t.string   "descripcion"
    t.integer  "especialidad_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tipos_consultas", ["descripcion"], name: "tipos_consultas_descripcion_key", unique: true, using: :btree

  create_table "tipos_documentos", force: true do |t|
    t.integer  "codigo"
    t.string   "descripcion", limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tipos_documentos", ["codigo"], name: "tipos_documentos_codigo_key", unique: true, using: :btree
  add_index "tipos_documentos", ["descripcion"], name: "tipos_documentos_descripcion_key", unique: true, using: :btree

  create_table "tipos_resoluciones", force: true do |t|
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tipos_resoluciones", ["descripcion"], name: "tipos_resoluciones_descripcion_key", unique: true, using: :btree

  create_table "tutores", force: true do |t|
    t.string    "nombres",                              null: false
    t.string    "apellidos",                            null: false
    t.string    "ci",         limit: 10,                null: false
    t.string    "direccion",  limit: 510
    t.string    "telefono",   limit: 12
    t.string    "image_url",  limit: nil
    t.string    "photo_uid",  limit: 510
    t.timestamp "created_at",             precision: 0
    t.timestamp "updated_at",             precision: 0
  end

  create_table "tutores_detalles", force: true do |t|
    t.integer  "tutor_id",      null: false
    t.integer  "alumno_id",     null: false
    t.integer  "parentezco_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", force: true do |t|
    t.integer  "persona_id",                                      null: false
    t.string   "login",                                           null: false
    t.string   "crypted_password",                                null: false
    t.string   "password_salt",                                   null: false
    t.string   "email"
    t.boolean  "active",                          default: false
    t.string   "persistence_token",                               null: false
    t.string   "single_access_token",                             null: false
    t.string   "perishable_token",                                null: false
    t.integer  "login_count",                     default: 0,     null: false
    t.integer  "failed_login_count",              default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "token",               limit: nil
    t.integer  "perfil_actual_id"
  end

  add_index "usuarios", ["persona_id"], name: "usuarios_idx", using: :btree

end
