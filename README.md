[![Build Status](https://travis-ci.org/FrancoB411/flashcard_hasher.svg?branch=master)](https://travis-ci.org/FrancoB411/flashcard_hasher)
# Flashcard Hasher 

Flashcard Hasher transforms specially formatted Markdown files into a hash of flash cards nested by heading.

So long as your markdown file contains
* headings
* data terms
* data definitions

Flashcard Hasher can turn it into a nice nested hash ready for serialization.

## Heads Up: WIP

The output format is still very much in flux here people. It's a 0.1.0. So if you depend on this, you're pretty adventurous.

## Why build this?

Well, if you could take all those notes you've accumulated over the years and turn them into flashcards...

And you could import those flashcards into a sick flashcard app you're working on that would remind you to study only what you're about to forget..

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

Say you have a markdown file with a bunch of headings, terms and definitions, like [this](https://github.com/FrancoB411/flashcard_hasher/blob/master/spec/fixtures/sample_input.md).

Run this:

```ruby
md = File.read('path/to/your/markdown/file.md')
flashcard_hash = FlashcardHasher.parse(md)
```

Then this: 

```ruby
flashcard_hash.to_json
```

And you should get a nice JSON like [this](https://github.com/FrancoB411/flashcard_hasher/blob/master/spec/fixtures/sample_output.json).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/francob411/flashcard_hasher.

This project is intended to be a safe, welcoming space for collaboration so, you know, be nice.

## License

The little gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

