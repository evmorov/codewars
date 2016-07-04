module Codewars
  class Attempt < Thor
    def initialize
      api_key = Configuration.option('api_key')
      raise Thor::Error, 'You should set an api-key to use this command' unless api_key

      desc = Description.new
      project_id = desc.take_value_from_file(/Project ID: (.+)/, 'Project ID')
      solution_id = desc.take_value_from_file(/Solution ID: (.+)/, 'Solution ID')
      solution = read_solution_file

      client = CodewarsApi::Client.new(api_key: api_key)
      attempt = client.attempt_solution(
        project_id: project_id,
        solution_id: solution_id,
        code: solution
      )

      say 'Your solution has been uploaded. Waiting for a result of tests on the server.'

      deferred_response = deferred_response(client, attempt)
      handle_deferred_response(deferred_response)
    end

    private

    def read_solution_file
      file_name = 'solution.*'
      solution_filename = Dir.glob(file_name).first
      unless solution_filename
        raise Thor::Error, "The file '#{file_name}' has not been found in the current directory."
      end
      File.read File.expand_path(solution_filename)
    end

    def deferred_response(client, attempt)
      seconds = ENV['CHECK_TIMEOUT'] || 10
      seconds.to_i.times do
        deferred_response = client.deferred_response(dmid: attempt.dmid)
        return deferred_response if deferred_response.success
        sleep 1
      end
      nil
    end

    def handle_deferred_response(deferred_response)
      if deferred_response.nil? || !deferred_response.success
        raise Thor::Error, "Can't get a result of tests on the server. Try it again."
      end

      if deferred_response.valid
        say 'The solution has passed all tests on the server.'
        say 'Type to finalize the solution: ' + set_color('codewars finalize', :blue, true)
      else
        error 'The solution has not passed tests on the server. Response:'
        raise Thor::Error, set_color(deferred_response.reason, :red)
      end
    end
  end
end
