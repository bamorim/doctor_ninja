require_relative "./minitest_helper"
require "doctor_ninja/document"
require "doctor_ninja/errors"

class DocumentTest < MiniTest::Test
  def test_valid_file
    @doc = DoctorNinja::Document.new("test/fixtures/limites.docx")
  end

  def test_invalid_file
    assert_raises(::DoctorNinja::InvalidDocumentError) do
      ::DoctorNinja::Document.new("test/fixtures/invalid_file.docx")
    end
  end
end
