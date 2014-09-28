require_relative "../parsers"
require "pry"

module Ninjadoc::Parsers::Paragraph
  @@style_map = {
    "h1" => /^Tí?tulo$/,
    "h2" => /^Subtí?tulo$/,
    "p" => //
  }
  def self.applicable_to?(node)
    node.name == "p"
  end

  def self.parse(node, yielder)
    style = begin 
      node.xpath("./w:pPr/w:pStyle").first.attributes["val"].value 
    rescue
      nil
    end

    tag = style == nil ? "p" : @@style_map.select do |k,v|
      v =~ style
    end.first[0]
    
    "<#{tag}>#{node.children.inject("") do |str,child|
      str + yielder.call(child)
    end}</#{tag}>"
  end

  Ninjadoc::Parsers.register self
end
