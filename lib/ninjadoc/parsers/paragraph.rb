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
    "<#{tag}>#{parse_children}</#{tag}>"
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

  Ninjadoc::Parsers.register self
end
