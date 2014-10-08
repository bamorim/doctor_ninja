require "zip"
require "ninjadoc/parser"

module Ninjadoc
  class Document
    def initialize file
      @file = Zip::File.new(file)
    rescue Zip::Error
      raise InvalidDocumentError.new
    end

    def document
      @file.read("word/document.xml")
    end

    def to_html
      Ninjadoc::Parser.new(self).parse
    end

    def close
      @file.close
    end
  end
end
