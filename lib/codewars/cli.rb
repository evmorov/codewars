module Codewars
  class CLI < Thor
    desc 'config SUBCOMMAND ...ARGS', 'Write options to the configuration file'
    subcommand 'config', Config

    desc 'train', 'Train a next kata'
    def train(id_or_slug = nil)
      if id_or_slug
        TrainSpecific.new(client, id_or_slug)
      else
        TrainNext.new(client)
      end
    end

    desc 'attempt', 'Send a solution and get a result'
    def attempt
      Attempt.new(client)
    end

    desc 'finalize', 'Finalize the previously attempted solution'
    def finalize
      Finalize.new(client)
    end

    private

    def client
      api_key = read_api_key
      CodewarsApi::Client.new(api_key: api_key)
    end

    def read_api_key
      api_key = Configuration.option('api_key')
      api_key || raise(Thor::Error, 'You should set an api-key to use this command')
    end
  end
end
