require_relative "./base"

class DoctorNinja::Parsers::Math < DoctorNinja::Parsers::Base
  @@xsl = File.join(File.dirname(__FILE__),"omml2mml.xsl")

  def self.applicable_to?(node)
    node.name == "oMath"
  end

  # Uses saxon to convert by now
  def parse
    doc = Nokogiri::XML(mml)
    doc.remove_namespaces!
    doc.root.set_attribute "xmlns", "http://www.w3.org/1998/Math/MathML"
    doc.root.set_attribute "display", "block" if @context[:is_math_para]
    doc.root.to_xml
  end

  def mml
    doc = Nokogiri::XML("<root>#{@node.to_xml(encoding: "utf-8")}</root>")

    @node.namespaces.each do |k,v|
      doc.root.add_namespace k.split(":")[1], v
    end

    xslt = Nokogiri::XSLT(File.read(@@xsl))
    xslt.transform(Nokogiri::XML(doc.to_xml)).to_xml
  end
end
