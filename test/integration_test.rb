# encoding: UTF-8
require "minitest/autorun"
require "doctor_ninja"

class IntegrationTest < MiniTest::Test
  def test_valid_file
    @doc = DoctorNinja::Document.new("test/fixtures/limites.docx")
    @parser = DoctorNinja::Parser.new(@doc)
    @result = @parser.parse

    assert_includes(@result, "<h1>Introdução aos Limites</h1>")
    assert_includes(@result, "<h2>Introdução</h2>")
    assert_includes(@result, "<b>O limite")
    assert_includes(@result, "<u>Mas a verdade é")
    
    math = <<-MATH
      <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mfrac>
          <mrow>
            <mn>1</mn>
          </mrow>
          <mrow>
            <mn>0</mn>
          </mrow>
        </mfrac>
        <mo>=</mo>
        <mi>∞</mi>
      </math>
    MATH

    assert_includes(@result.gsub(/[\n ]/,""), math.gsub(/[\n ]/,""))
  end
end
