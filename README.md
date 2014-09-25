# Ninjadoc

Ninjadoc is a library to convert word documents into html files like a ninja.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ninjadoc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ninjadoc

## Usage

To use it, you first load the .docx file and then use the to_html to get the html.

    doc = Ninjadoc::Document.new('path_to_file.docx')
    doc.to_html

## Contributing

1. Fork it ( https://github.com/bamorim/ninjadoc/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
