require_relative "./base"

class Ninjadoc::Parsers::BlipFill < Ninjadoc::Parsers::Base
  def self.applicable_to?(node)
    node.name == "blipFill"
  end

  def parse
    @context.background_image = Magick::Image.from_blob(@document.relationships["rId5"]).first
  end
end
