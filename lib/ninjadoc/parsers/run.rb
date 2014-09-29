require_relative "./base"

class Ninjadoc::Parsers::Run < Ninjadoc::Parsers::Base
  @@available_tags = ["b", "u", "i"]

  def self.applicable_to?(node)
    node.name == "r"
  end

  def parse
    tag = nil
    if @node.xpath(".//w:rPr/w:b").length > 0
      tag = "b"
    end

    tags.inject(@node.text){|text,tag| "<#{tag}>#{text}</#{tag}>"}
  end

  def tags
    @node.xpath("./w:rPr").children
      .map{|n| n.name}
      .select{|n| @@available_tags.include? n}
  end

  Ninjadoc::Parsers.register self
end
