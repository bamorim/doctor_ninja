require_relative "../parsers"

module Ninjadoc::Parsers::Run
  def self.applicable_to?(node)
    node.name == "r"
  end

  def self.parse(node, yielder)
    node.text
  end

  Ninjadoc::Parsers.register self
end
