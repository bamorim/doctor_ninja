require_relative "./base"

class Ninjadoc::Parsers::BlipFill < Ninjadoc::Parsers::Base
  def self.applicable_to?(node)
    node.name == "blipFill"
  end

  def parse
    @context.background_image = Magick::Image.from_blob(@document.relationships[rel_id]).first
  end

  def rel_id
    node.xpath("./a:blip").attribute("r:embed").value
  end
end
