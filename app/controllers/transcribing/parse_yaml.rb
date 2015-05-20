require 'yaml'

def transform_lang(language)
	hash = YAML.load(File.read(Rails.root.to_s + "/app/controllers/transcribing/config_lang.yml"))
	hash[language].to_s
end
