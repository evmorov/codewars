module Codewars
  class Config < Thor
    desc 'key YOUR_SECRET_KEY', 'Your api key'
    def key(secret_key)
      Configuration.write_option_to_config('api_key', secret_key)
      say "You've successefully added the api-key to the configuration file"
    end

    desc 'language DEFAULT_LANGUAGE', 'A default language to use'
    def language(default_language)
      Configuration.write_option_to_config('language', default_language)
      say "You've successefully added the default language to the configuration file"
    end
  end
end
