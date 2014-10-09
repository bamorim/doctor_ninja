require_relative "./base"

class DoctorNinja::Parsers::BlipFill < DoctorNinja::Parsers::Base
  def self.applicable_to?(node)
    node.name == "blipFill"
  end

  def parse
    @image = Magick::Image.from_blob(@document.relationships[rel_id]).first
    transform
    @context.background_image = @image
  end

private

  def rel_id
    @node.xpath("./a:blip", "a" => xmlns_a).attribute("embed").value
  end

  def transform
    return unless src_rect
    h = {
      "l" => src_rect["l"].to_i*@image.columns/100000,
      "t" => src_rect["t"].to_i*@image.rows/100000,
      "r" => src_rect["r"].to_i*@image.columns/100000,
      "b" => src_rect["b"].to_i*@image.rows/100000
    }
    @image = @image.crop(
      h["l"],
      h["t"],
      @image.columns - h["l"]-h["r"] ,
      @image.rows-h["b"]-h["t"]
    )
  end

  def src_rect
    @node.xpath("./a:srcRect","a" => xmlns_a)[0]
  end

  def xmlns_a
    @node.namespaces["xmlns:a"]
  end
end
