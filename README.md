# Flashcard Hasher 

Flashcard Hasher transforms specially formatted Markdown files into a hash of flash cards nested by heading.

So long as your markdown file contains
* headings
* data terms
* data definitions

Flashcard Hasher can turn it into a nice nested hash ready for serialization.

## Why would anyone do this?

Well, if you could take all those notes you've accumulated over the years and turn them into flashcards...

Ans you could import those flashcards into a sick flash card app you're working on that would remind you to study only what you're about to forget..

That would be cool. 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flashcard_hasher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flashcard_hasher 

## Usage

Say you have a markdown file with a bunch of headings and definitions, like the [sample_import.md](#).

Run this:

```ruby
flashcard_hash = FlashcardHasher.parse('path/to/your/markdown/file.md')
```

Then this: 

```ruby
flashcard_hash.to_json
```

And you should get a nice JSON like [sample_import.json](#).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_from_notes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to be nice.  

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

