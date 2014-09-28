require "minitest/autorun"
require "ninjadoc"

class IntegrationTest < MiniTest::Test
  def test_valid_file
    @doc = Ninjadoc::Document.new("test/fixtures/limites.docx")
    @parser = Ninjadoc::Parser.new(@doc)
    @result = @parser.parse

    assert_includes(@result, "<h1>Introdução aos Limites</h1>")
    assert_includes(@result, "<h2>Introdução</h2>")
    assert_includes(@result, "<b>O limite")
  end
end
