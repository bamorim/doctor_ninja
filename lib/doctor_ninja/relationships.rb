module DoctorNinja
  class Relationships
    def initialize(doc)
      @doc = doc
      @rels = Nokogiri::XML @doc.read "word/_rels/document.xml.rels"
    end

    def read id
      @doc.read "word/#{path id}"
    end

    def with id
      file = Tempfile.new(id)
      file.write(read(id))
      file.close
      yield file.path
    ensure
      file.unlink
    end

    alias_method :[], :read

    def path id
      @rels.xpath("//*[@Id=\"#{id}\"]").attribute("Target").value
    rescue
      nil
    end
  end
end
