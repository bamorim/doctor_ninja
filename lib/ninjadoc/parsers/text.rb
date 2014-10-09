require_relative "./base"

class Ninjadoc::Parsers::Text < Ninjadoc::Parsers::Base
  def self.applicable_to?(node)
    node.text?
  end

  def parse
    @node.text
  end
end
