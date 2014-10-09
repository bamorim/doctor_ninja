require "zip"
require "ninjadoc/parser"
require "ninjadoc/relationships"

module Ninjadoc
  class Document
    def initialize file
      @file = Zip::File.new(file)
    rescue Zip::Error
      raise InvalidDocumentError.new
    end

    def relationships
      @relationships ||= Ninjadoc::Relationships.new(self)
    end

    def read file
      @file.read(file)
    end

    def to_html
      Ninjadoc::Parser.new(self).parse
    end

    def close
      @file.close
    end
  end
end
