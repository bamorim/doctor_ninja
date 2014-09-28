require_relative "../parsers"

module Ninjadoc::Parsers::Noop
  def self.applicable_to?(node)
    return true
  end

  def self.parse(node, yielder)
    node.children.inject("") do |str,child|
      str << yielder.call(child)
    end
  end

  Ninjadoc::Parsers.register self
end
