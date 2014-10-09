require "ninjadoc/parsers/base"

class Ninjadoc::Parsers::Paragraph < Ninjadoc::Parsers::Base
  @@style_map = {
    /^T[í|i]t(ulo|le)$/ => "h1",
    /^Subt[í|i]t(ulo|le)$/ => "h2",
    // => "p"
  }

  def self.applicable_to?(node)
    node.name == "p"
  end

  def parse
    @context[:has_text] = false
    content = parse_children
    attrs = {}
    style = {}
    style["text-align"] = "center" unless @context[:has_text]

    attrs["style"] = style.map{|k,v| "#{k}:#{v};"}.join(" ") if style.length > 0

    attrs = attrs.map{|k,v| " #{k}=\"#{v}\""}.join("")
    "<#{tag}#{attrs}>#{content}</#{tag}>"
  end

  def tag
    style == nil ? "p" : @@style_map.select do |k,v|
      k =~ style
    end.first[1]
  end

  def style
    @node.xpath("./w:pPr/w:pStyle").first.attributes["val"].value 
  rescue
    nil
  end
end
