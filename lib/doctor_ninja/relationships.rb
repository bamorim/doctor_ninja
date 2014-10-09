module DoctorNinja
  class Relationships
    def initialize(doc)
      @doc = doc
      @rels = Nokogiri::XML @doc.read "word/_rels/document.xml.rels"
    end

    def read id
      @doc.read "word/#{path id}"
    end

    alias_method :[], :read

    def path id
      @rels.xpath("//*[@Id=\"#{id}\"]").attribute("Target").value
    rescue
      nil
    end
  end
end
