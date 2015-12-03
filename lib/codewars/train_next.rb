module Codewars
  class TrainNext < Thor::Shell::Basic
    def initialize
      message = []
      api_key = Configuration.option('api_key')
      message.push 'You should set an api-key to use this command' unless api_key
      language = Configuration.option('language')
      message.push 'You should set an default language to use this command' unless language
      fail Thor::Error, message.join("\n") unless message.empty?

      client = CodewarsApi::Client.new(api_key: api_key)
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
        fail Thor::Error, 'Wrong api key'
      end
      Description.new.print_kata_desc(kata)
    end
  end
end
