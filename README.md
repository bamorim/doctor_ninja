Here be dragons! This is a WIP.

# Ninjadoc

Ninjadoc is a library to convert word documents into html files like a ninja.

## TODO

* Pass styleMap as an option(to choose what tag in paragraph rendering)
* Add suport for images
* Add general configurations:
  1. style map
  2. image inline(src=data)/as file
  3. MathML/ansimath/latex
* Finish the desired api `doc.to_html`

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
