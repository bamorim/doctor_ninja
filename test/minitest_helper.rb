require 'minitest/reporters'
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)
require 'minitest/autorun'

class MiniTest::Test
  protected
  def parse_file(file)
    doc = DoctorNinja::Document.new(file)
    parser = DoctorNinja::Parser.new(doc)
    parser.parse
  end

  def strip_spaces str
    str.gsub(/[\n ]+/," ").gsub("> ",">").gsub(" <","<")
  end
end
