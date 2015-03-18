require_relative "./base"
require "rvg/rvg"
require "base64"

class DoctorNinja::Parsers::Drawing < DoctorNinja::Parsers::Base
  include Magick

  def self.applicable_to?(node)
    node.name == "drawing"
  end

  def parse
    width = extent[:x]/DoctorNinja::EMU_PER_PIXEL
    height = extent[:y]/DoctorNinja::EMU_PER_PIXEL

    rvg = RVG.new(width,height).viewbox(0,0,width,height) do |canvas|
      context = @context.dup
      context[:canvas] = canvas
      parse_children(context)
    end

    format = "png"
    base64 = Base64.encode64 rvg.draw.to_blob { self.format = format }

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
