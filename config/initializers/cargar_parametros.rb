#PARAMETRO = YAML.load_file(Rails.root.join('config', 'parametros.yml'))[Rails.env].symbolize_keys
#APP_CONFIG = YAML.load_file(Rails.root.join('config', 'config.yml'))[Rails.env].symbolize_keys
#yaml_data = File.read('your_yaml_file.yml')
#parameters = Psych.safe_load(yaml_data, aliases: true)
#PARAMETRO = Psych.safe_load(Rails.root.join('config', 'parametros.yml'))[Rails.env].symbolize_keys
#APP_CONFIG = File.read(Rails.root.join('config', 'config.yml'))[Rails.env].symbolize_keys
yaml_path_parametros = Rails.root.join('config', 'parametros.yml')
yaml_content_parametros = File.read(yaml_path_parametros).force_encoding('UTF-8')

yaml_path_config = Rails.root.join('config', 'config.yml')
yaml_content_config = File.read(yaml_path_config).force_encoding('UTF-8')

# Use Psych.safe_load with aliases: true
PARAMETRO = Psych.safe_load(yaml_content_parametros, aliases: true)[Rails.env].symbolize_keys
APP_CONFIG = Psych.safe_load(yaml_content_config, aliases: true)[Rails.env].symbolize_keys