module DoctorNinja
  module Parsers
    class Base
      def self.applicable_to?(node)
        false
      end

      def initialize(node, yielder, document, context)
        @node = node
        @yielder = yielder
        @document = document
        @context = context
      end

      def parse
        parse_children
      end

      def parse_children(context=@context)
        @node.children.inject("") do |str,child|
          str << @yielder.call(child,context).to_s
        end
      end
    end
  end
end
