module Codewars
  class LanguageExtensions
    MAPPING = {
      'ruby' => 'rb',
      'coffeescript' => 'coffee',
      'javascript' => 'js',
      'python' => 'py',
      'haskell' => 'hs',
      'csharp' => 'cs',
      'closure' => 'clj'
    }.freeze

    def self.get(language)
      extension = MAPPING[language]
      extension ? extension : language
    end
  end
end
