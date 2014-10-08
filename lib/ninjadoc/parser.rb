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
      parsers = parsers_for(node)

      if debug?(node,parsers)
        debug(node,binding)
      end

      parsers
        .first
        .parse
    end

    def parsers_for(node)
      Ninjadoc::Parsers
        .parsers
        .select{|p| p.applicable_to? node}
        .map{|p| p.new(node, self.public_method(:parse_node))}
    end

    def debug?(node,parsers)
      ENV["DEBUG"] == "all" || 
      (ENV["DEBUG"] == "missing" && parsers.length == 1) || 
      ENV["DEBUG"] == node.name ||
      (node.namespace && ENV["DEBUG"] == "#{node.namespace.prefix}:#{node.name}")
    end

    def debug(node,b)
      if(ENV["DEBUG_MODE"]=="pry")
        require "pry"
        b.pry
      else
        puts "---BEGIN---\n#{node.to_xml}\n----END----"
      end
    end
  end
end
