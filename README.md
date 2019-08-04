# David

David is a ruby gem (command line) to record child's stories for geek daddy or mommy. 

## Installation

Install it yourself as:

```
$ gem install david
```

### Requirements

* Ruby (>= 2.0)
* Sqlite3

## Usage

Alias your child's name to the `david` command, append bellow to `~/.bashrc`. For example, child's name is 'Ian':

```
alias ian='david -nian'
```

Just type command to record Ian's stories:

```
$ ian play with david
```

Or record a stories before:

```
$ ian play with david on 2018-02-01
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hutusi/david. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

### Todolist

- [ ] Record child's history stories.
- [ ] Discriminate verb's tense.
- [ ] Ask about child's stories. (What did david do on 2018-02-01?)
- [ ] Record child's favorites.
- [ ] Support more children.
- [ ] Encrypt database.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the David project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hutusi/david/blob/master/CODE_OF_CONDUCT.md).
