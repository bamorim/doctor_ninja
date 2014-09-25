require "zip"

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
  end
end
