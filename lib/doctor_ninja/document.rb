require "zip"
require "doctor_ninja/parser"
require "doctor_ninja/relationships"
require "doctor_ninja/numbering"

module DoctorNinja
  class Document
    def initialize file
      @file = Zip::File.new(file)
    rescue Zip::Error
      raise InvalidDocumentError.new
    end

    def relationships
      @relationships ||= DoctorNinja::Relationships.new(self)
    end

    def numbering
      @numbering ||= DoctorNinja::Numbering.new(self)
    end

    def read file
      @file.read(file)
    end

    def to_html
      DoctorNinja::Parser.new(self).parse
    end

    def close
      @file.close
    end
  end
end
