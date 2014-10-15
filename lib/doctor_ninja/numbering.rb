module DoctorNinja
  class Numbering
    def initialize(doc)
      @doc = doc
      numbering = @doc.read "word/numbering.xml"
      @numb = Nokogiri::XML numbering if numbering
    end

    def style level, num_id
      abstract_num(num_id).xpath(".//w:lvl[@w:ilvl=\"#{level}\"]//w:numFmt/@w:val")[0].value
    rescue
      nil
    end

  protected
    def abstract_num num_id
      @numb.xpath("//w:abstractNum[@w:abstractNumId=\"#{abstract_num_id(num_id)}\"]")
    end

    def abstract_num_id num_id
      @numb.xpath("//w:num[@w:numId=\"#{num_id}\"]/w:abstractNumId/@w:val")[0].value
    end
  end
end
