# encoding: UTF-8
require_relative "./minitest_helper"
require "doctor_ninja"
require "phashion"

class ListsTest < MiniTest::Test
  def test_unordered_list
    result = parse_file "test/fixtures/unordered_list.docx"
    bullet1 = "<li>Bullet 1</li>"
    bullet2 = <<-HTML
    <li>Bullet 2
      <ul>
        <li>Bullet 2.1</li>
        <li>Bullet 2.2
          <ul>
            <li>Bullet 2.2.1
              <ul><li>Bullet 2.2.1.1</li>
    HTML
    assert_includes result, bullet1
    assert_includes strip_spaces(result), strip_spaces(bullet2)
  end

  def test_ordered_list
    result = parse_file "test/fixtures/ordered_list.docx"
    bullet2 = <<-HTML
    <li>Bullet 2
      <ol>
        <li>Bullet 2.1</li>
        <li>Bullet 2.2
          <ol>
            <li>Bullet 2.2.1
              <ol><li>Bullet 2.2.1.1</li></ol>
    HTML
    assert_includes strip_spaces(result), strip_spaces(bullet2)
  end
end
