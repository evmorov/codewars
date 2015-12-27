# Codewars command-line tool

## Installation

Execute `gem install codewars`

## Usage

Execute `codewars help` to see all available commands.

1. Set an API ACCESS TOKEN from the codewars website (https://www.codewars.com/users/edit) `codewars config key your-secret-key`
2. Set a language you want to use `codewars config language ruby|javascript|etc`
3. Choose a kata which you want to solve `codewars train`
4. Start solving the kata `codewars train name-of-kata`
5. Go to created folder `cd name-of-kata/language/`
6. Look at description.md (use a Markdown viewer)
7. According to the description of the kata change or create tests using your favorite test framework
8. Change the solution.* file so the tests become green
9. Upload the solution and wait for a response of tests on the server `codewars attempt`
10. If there are no mistakes finalize the previously attempted solution `codewars finalize`
11. Look at results of other people, rest and pick up another kata or the same kata but using another language

### Problems

Not sure for purpose or not but API sometimes caches a request for the next kata. To solve the problem go to the link http://www.codewars.com/dashboard in your browser.

## Development

### TO-DO

- [ ] Refactor anything you can
- [ ] Add travis, coveralls, etc
- [ ] After `codewars finalize` show a link with the language of submission
- [ ] Change the name of commands: attempt and finalize (join them to one command?)
- [ ] Rename 'config' command? Maybe to 'set'?
- [ ] Add options to commands that can be added: --strategy=something, --language=something, etc.
- [ ] Make 100% coverage in simplecov
- [ ] Write RSpec module tests
- [ ] Divide description.md to task.md + info.yml?
- [ ] Refactor features so stubbing (mocking) become more obvious
- [ ] Make a bug report "Author's name in an API response is yours name"

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
