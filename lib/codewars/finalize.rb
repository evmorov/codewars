module Codewars
  class Finalize < Thor
    def initialize
      api_key = Configuration.option('api_key')
      fail Thor::Error, 'You should set an api-key to use this command' unless api_key

      desc = Description.new
      slug = desc.take_value_from_file(/Slug: (.+)/, 'Slug')
      project_id = desc.take_value_from_file(/Project ID: (.+)/, 'Project ID')
      solution_id = desc.take_value_from_file(/Solution ID: (.+)/, 'Solution ID')

      client = CodewarsApi::Client.new(api_key: api_key)
      result = client.finalize_solution(
        project_id: project_id,
        solution_id: solution_id
      )
      handle_result(result, slug)
    end

    private

    def handle_result(result, slug)
      if result.success
        say 'Your solution has been finalized.'
        say "Other solutions can be found here: #{CODEWARS_URL}/kata/#{slug}/solutions/"
      else
        fail Thor::Error, 'Something went wrong. Try to sumbit the solution again.'
      end
    end
  end
end
