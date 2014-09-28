require_relative "./base"

class Ninjadoc::Parsers::Paragraph < Ninjadoc::Parsers::Base
  @@style_map = {
    "h1" => /^Tí?tulo$/,
    "h2" => /^Subtí?tulo$/,
    "p" => //
  }

  def self.applicable_to?(node)
    node.name == "p"
  end

  def parse
    style = begin 
      @node.xpath("./w:pPr/w:pStyle").first.attributes["val"].value 
    rescue
      nil
    end

    tag = style == nil ? "p" : @@style_map.select do |k,v|
      v =~ style
    end.first[0]
    
    "<#{tag}>#{parse_children}</#{tag}>"
  end

  Ninjadoc::Parsers.register self
end
