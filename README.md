Here be dragons! This is a WIP.

# DoctorNinja

DoctorNinja is a library to convert word documents into html files like a ninja.

## Features

* Convert images and applies the following transformations
  * Crop
* Convert Microsoft's Math to MathML
* Accepts bold, italic and underline
* Sets text-align to center when there are only non-text children on paragrpahs ( This is for our own usecase, we should probably give an interface to configure it, maybe passing a lambda )

## TODO

* Pass styleMap as an option(to choose what tag in paragraph rendering)
* Add general configurations:
  1. style map
  2. image inline(src=data)/as file
  3. MathML/ansimath/latex

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doctor_ninja'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doctor_ninja

## Usage

To use it, you first load the .docx file and then use the to_html to get the html.

```ruby
doc = DoctorNinja::Document.new('path_to_file.docx')
doc.to_html
```

Alternativly, you can use our binary, that wraps inside a html boilerplate and adds MathJax to correcly render the MathML

    $> doctor_ninja document.docx document.html

## Contributing

1. Fork it ( https://github.com/bamorim/doctor_ninja/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
