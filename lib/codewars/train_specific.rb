require 'erb'
require 'fileutils'

module Codewars
  class TrainSpecific < Thor
    def initialize(id_or_slug)
      message = []
      api_key = Configuration.option('api_key')
      message.push 'You should set an api-key to use this command' unless api_key
      languages = Configuration.option('language')
      message.push 'You should set an default language to use this command' unless languages
      fail Thor::Error, message.join("\n") unless message.empty?

      say "Starting the '#{id_or_slug}' kata."

      client = CodewarsApi::Client.new(api_key: api_key)
      languages.split(',').each do |language|
        kata = client.train_specific_kata(language: language, id_or_slug: id_or_slug) rescue next
        handle_specific_kata(kata, language)
      end
    end

    private

    def handle_specific_kata(kata, language)
      slug = kata.slug
      write_kata(slug, language, 'description.md', description(kata, language))
      exten = LanguageExtensions.get(language)
      unless kata.tests_setup.to_s.empty?
        write_kata(slug, language, "test.#{exten}", kata.tests_setup)
      end
      write_kata(slug, language, "solution.#{exten}", kata.code_setup)
    end

    def write_kata(slug, language, file_name, content)
      dir_to_write = File.expand_path(slug)
      FileUtils.mkdir_p "#{dir_to_write}/#{language}"
      file_path = File.expand_path("#{dir_to_write}/#{language}/#{file_name}")
      relative_path = "./#{slug}/#{language}/#{file_name}"
      fail Thor::Error, "'#{relative_path}' already exists." if File.exist? file_path

      File.write(file_path, content)
      say "'#{relative_path}' has been created."
    end

    def description(kata, language)
      b = binding
      b.local_variable_set(:kata, kata)
      b.local_variable_set(:language, language)
      b.local_variable_set(:codewars_url, CODEWARS_URL)
      template_path = File.expand_path("#{File.dirname(__FILE__)}/description_template.erb")
      ERB.new(File.read template_path).result(b)
    end
  end
end
