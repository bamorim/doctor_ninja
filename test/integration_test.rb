require "minitest/autorun"
require "ninjadoc"

class IntegrationTest < MiniTest::Test
  def test_valid_file
    @doc = Ninjadoc::Document.new("test/fixtures/limites.docx")
    @parser = Ninjadoc::Parser.new(@doc)
    puts "Testing"
    assert_includes(@parser.parse, "<h1>Introdu")
  end
end
