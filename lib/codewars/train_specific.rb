require 'erb'
require 'fileutils'

module Codewars
  class TrainSpecific < Thor
    def initialize(client, id_or_slug)
      language = Configuration.option('language')
      raise Thor::Error, 'You should set an default language to use this command' unless language

      say "Starting the '#{id_or_slug}' kata."

      kata = client.train_specific_kata(language: language, id_or_slug: id_or_slug)
      handle_specific_kata(kata, language)
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
      raise Thor::Error, "'#{relative_path}' already exists." if File.exist? file_path

      File.write(file_path, content)
      say "'#{relative_path}' has been created."
    end

    def description(kata, language)
      b = binding
      b.local_variable_set(:kata, kata)
      b.local_variable_set(:language, language)
      b.local_variable_set(:codewars_url, CODEWARS_URL)
      template_path = File.expand_path("#{File.dirname(__FILE__)}/description_template.erb")
      ERB.new(File.read(template_path)).result(b)
    end
  end
end
