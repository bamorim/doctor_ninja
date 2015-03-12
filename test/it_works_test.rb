require_relative "./minitest_helper"
require "minitest/autorun"
require "doctor_ninja"

class ItWorksTest < MiniTest::Test
  Dir.glob("./test/fixtures/it_works/*.docx").each do |f|
    define_method(:"test_it_works_#{File.basename(f,".*").downcase}") do
      parse_file(f)
    end
  end
end
