module Ninjadoc
  module Parsers
    @@parsers = []

    def self.parsers
      @@parsers
    end

    def self.register parser
      @@parsers << parser
    end
  end
end

require "ninjadoc/parsers/run"
require "ninjadoc/parsers/paragraph"

#Noop should always be the last
require "ninjadoc/parsers/noop"
