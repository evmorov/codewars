# Codewars command-line tool

## Installation

Execute `gem install codewars`

## Usage

Execute `codewars help` to see all available commands.

1. Set TOKEN from https://www.codewars.com/users/edit `codewars config key your-secret-key`
2. Set a language `codewars config language ruby|javascript|etc`
3. Choose a kata `codewars train`
4. Start solving `codewars train name-of-kata`
5. Open a folder `cd name-of-kata/language/`
6. Create tests according on description.md
7. Make the tests green
8. Attempt the solution on the server `codewars attempt`
9. Refactor your code
10. Finalize `codewars finalize`

### Problems

Not sure for purpose or not but API sometimes caches a request for the next kata. To solve the problem go to the link http://www.codewars.com/dashboard in your browser.

## Contributing

Bug reports, pull requests and ideas are welcome!

Steps to make a pull request:

1. Fork it ( https://github.com/evmorov/codewars/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make changes
4. Add tests for it
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new Pull Request
