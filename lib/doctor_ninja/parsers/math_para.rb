require_relative "./base"

class DoctorNinja::Parsers::MathPara < DoctorNinja::Parsers::Base
  def self.applicable_to?(node)
    node.name == "oMathPara"
  end

  def parse
    @context = @context.dup
    @context[:is_math_para] = true
    parse_children
  end
end
