require_relative "../parsers"

module Ninjadoc::Parsers::Run
  def self.applicable_to?(node)
    node.name == "r"
  end

  def self.parse(node, yielder)
    tag = nil
    if node.xpath(".//w:rPr/w:b").length > 0
      tag = "b"
    end

    if(tag)
      "<#{tag}>#{node.text}</#{tag}>"
    else
      node.text
    end
  end

  Ninjadoc::Parsers.register self
end
