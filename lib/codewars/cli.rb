module Codewars
  class CLI < Thor
    desc 'config SUBCOMMAND ...ARGS', 'Write options to the configuration file'
    subcommand 'config', Config

    desc 'train', 'Train a next kata'
    def train(id_or_slug = nil)
      if id_or_slug
        TrainSpecific.new(id_or_slug)
      else
        TrainNext.new
      end
    end

    desc 'attempt', 'Send a solution and get a result'
    def attempt
      Attempt.new
    end

    desc 'finalize', 'Finalize the previously attempted solution'
    def finalize
      Finalize.new
    end
  end
end
