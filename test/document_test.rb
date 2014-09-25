require "minitest/autorun"
require_relative "../lib/ninjadoc/document.rb"
require_relative "../lib/ninjadoc/errors.rb"

class DocumentTest < MiniTest::Test
  def test_valid_file
    @doc = Ninjadoc::Document.new("test/fixtures/limites.docx")
  end

  def test_invalid_file
    assert_raises(::Ninjadoc::InvalidDocumentError) do
      ::Ninjadoc::Document.new("test/fixtures/invalid_file.docx")
    end
  end
end
