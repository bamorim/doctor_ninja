require_relative "./base"

class DoctorNinja::Parsers::Text < DoctorNinja::Parsers::Base
  def self.applicable_to?(node)
    node.text?
  end

  def parse
    @context[:has_text] = true
    @node.text
  end
end
