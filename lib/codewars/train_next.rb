module Codewars
  class TrainNext < Thor
    def initialize(client)
      language = Configuration.option('language')
      raise Thor::Error, 'You should set an default language to use this command' unless language

      kata = client.train_next_kata(
        language: language,
        peek: 'true',
        strategy: 'default'
      )
      handle_next_kata(kata)
    end

    private

    def handle_next_kata(kata)
      if !kata.success && (kata.reason.eql? 'unauthorized')
        raise Thor::Error, 'Wrong api key'
      end
      Description.new.print_kata_desc(kata)
    end
  end
end
