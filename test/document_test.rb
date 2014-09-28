require_relative "./minitest_helper"
require "ninjadoc/document"
require "ninjadoc/errors"

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
