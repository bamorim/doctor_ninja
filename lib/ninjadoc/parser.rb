require 'nokogiri'
require "ninjadoc/parsers"

module Ninjadoc
  class Parser

    def initialize(doc)
      @xmldoc = Nokogiri::XML(doc.document)
    end

    def parse
      self.parse_node(@xmldoc.root)
    end

    def parse_node(node)
      Ninjadoc::Parsers.parsers.select{|p| p.applicable_to? node}.first.parse(node, self.public_method(:parse_node))
    end
  end
end
