require 'yaml'

module Codewars
  class Configuration
    CONFIG_NAME = '.codewarsrc'.freeze

    def self.write_option_to_config(option, value)
      config_hash = config
      config_hash[option] = value

      config_str = ''
      config_hash.each { |k, v| config_str += "#{k}: #{v}\n" }
      File.write(config_path, config_str)
    end

    def self.config
      File.exist?(config_path) ? YAML.load_file(config_path) : {}
    end

    def self.config_path
      "#{ENV['HOME']}/#{CONFIG_NAME}"
    end

    def self.option(option)
      config[option]
    end
  end
end
