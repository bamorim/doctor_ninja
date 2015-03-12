require_relative "./base"
require "mini_magick"

class DoctorNinja::Parsers::BlipFill < DoctorNinja::Parsers::Base
  def self.applicable_to?(node)
    node.name == "blipFill"
  end

  def parse
    outfile = Tempfile.new("output.png")
    outfile.close
    @document.relationships.with(rel_id) do |path|
      begin
        process outfile, path
      rescue MiniMagick::Invalid => e
        raise e unless system("which unoconv")
        unoconv_and_process outfile, path
      end
    end
  ensure
    outfile.unlink
  end

private

  def unoconv_and_process outfile, original
    FileUtils.cp(original,"#{original}.emf")
    png = Tempfile.new("unoconv.png")
    png.close
    system("unoconv -o #{png.path} -f png #{original}.emf")
    process(outfile, png.path)
  ensure
    png.unlink
  end

  def process outfile, path
    @image = MiniMagick::Image.open(path)
    @width, @height = @image.dimensions
    transform
    @image.write(outfile.path)
    @context[:image_blob] = File.read(outfile)
  end

  def rel_id
    @node.xpath("./a:blip", "a" => xmlns_a).attribute("embed").value
  end

  def transform
    return unless src_rect
    l = src_rect["l"].to_i*@width/100000
    t = src_rect["t"].to_i*@height/100000
    r = src_rect["r"].to_i*@width/100000
    b = src_rect["b"].to_i*@height/100000
    w = @width-l-r
    h = @height-t-b
    result = "#{w}x#{h}!+#{l}+#{t}"
    @image.combine_options do |c|
      c.gravity 'NorthEast'
      c.crop(result)
    end
  end

  def src_rect
    @node.xpath("./a:srcRect","a" => xmlns_a)[0]
  end

  def xmlns_a
    @node.namespaces["xmlns:a"]
  end
end
