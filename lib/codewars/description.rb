module Codewars
  class Description < Thor
    DESCRIPTION_FILE_NAME = 'description.md'

    no_commands do
      def take_value_from_file(regex_with_group, param_key)
        @data ||= read_file(DESCRIPTION_FILE_NAME)
        param = @data.match(regex_with_group)
        unless param
          fail Thor::Error, "'#{param_key}' has not been found in the 'description.md' file."
        end
        param[1]
      end

      def print_kata_desc(kata)
        print_parameter('Name', kata.name)
        print_parameter('Link', "#{CODEWARS_URL}#{kata.href}")
        print_parameter('Description', kata.description)
        print_parameter('Tags', kata.tags.join(', ')) if kata.tags
        print_parameter('Rank', kata.rank.to_s) if kata.rank
        say ''
        print_parameter('Type to start this kata',
                        "codewars train #{kata.slug}", :blue, true)
      end
    end

    private

    def read_file(file_name)
      desc_path = File.expand_path(file_name)
      unless File.exist? desc_path
        fail Thor::Error, "The file '#{file_name}' has not been found in the current directory."
      end
      File.read(desc_path)
    end

    def print_parameter(parameter, value, value_color = nil, value_bold = false)
      say set_color("#{parameter}: ", :green) + set_color(value, value_color, value_bold)
    end
  end
end
