require "rvg/rvg"
require "base64"

class Ninjadoc::Parsers::Drawing < Ninjadoc::Parsers::Base
  RESOLUTION = 96
  EMU_PER_INCH = 914400
  EMU_PER_PIXEL = EMU_PER_INCH/RESOLUTION

  include Magick

  def self.applicable_to?(node)
    node.name == "drawing"
  end

  def parse
    width = extent[:x]/EMU_PER_PIXEL
    height = extent[:y]/EMU_PER_PIXEL

    rvg = RVG.new(width,height).viewbox(0,0,width,height) do |canvas|
      parse_children(canvas)
    end

    format = "jpeg"
    base64 = Base64.encode64 rvg.draw.to_blob { self.format = "jpeg" }

    "<img src=\"data:image/#{format};base64,#{base64}\"/>"
  end

  def extent
    @extent ||= {
      x: extent_node.attribute("cx").value.to_i,
      y: extent_node.attribute("cy").value.to_i
    }
  end

  def extent_node
    @node.xpath(".//wp:extent")
  end
end
