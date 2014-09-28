require_relative "../parsers"

class Ninjadoc::Parsers::Noop < Ninjadoc::Parsers::Base
  def self.applicable_to?(node)
    return true
  end

  def parse
    parse_children
  end

  Ninjadoc::Parsers.register self
end
