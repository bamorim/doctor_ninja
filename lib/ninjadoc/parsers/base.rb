require_relative "../parsers"

class Ninjadoc::Parsers::Base
  def self.applicable_to?(node)
    false
  end

  def initialize(node, yielder)
    @node = node
    @yielder = yielder
  end

  def parse_children
    @node.children.inject("") do |str,child|
      str << @yielder.call(child)
    end
  end
end
