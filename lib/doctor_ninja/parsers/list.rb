require_relative "./base"

class DoctorNinja::Parsers::List < DoctorNinja::Parsers::Base
  def self.applicable_to?(node)
    node.name == "p" && node.xpath("./w:pPr/w:numPr").length > 0
  end

  def parse
    num_id = get_pr "w:numId", @node
    lvl = get_pr "w:ilvl", @node
    style = @document.numbering.style(lvl, num_id)
    tag = style == "bullet" ? "ul" : "ol"
    type = case style
    when "lowerRoman"
      "i"
    when "upperRoman"
      "I"
    when "lowerLetter"
      "a"
    when "upperLetter"
      "A"
    else
      ""
    end
    typeAttr = type == "" ? "" : " type='#{type}'"

    num_id_query = ".//w:numId/@w:val=\"#{num_id}\""

    previous = @node.xpath("preceding-sibling::w:p[#{num_id_query}][1]")
    following = @node.xpath("following-sibling::w:p[#{num_id_query}][1]")

    prefix = ""
    # Add <ul> if is start of new list
    if previous.length == 0 || get_pr("w:ilvl", previous).to_i < lvl.to_i
      prefix += "<#{tag}#{typeAttr}>"
    end

    prefix += "<li>"
    
    suffix = ""

    f_lvl = (following.length == 0) ? -1 : get_pr("w:ilvl", following)

    closings = (f_lvl.to_i..lvl.to_i).map do |l|
      if l == lvl.to_i
        # Close only this item
        "</li>"
      elsif l < lvl.to_i && l >= 0
        # Close list level
        "</#{tag}></li>"
      else
        # Close entire list
        "</#{tag}>"
      end
    end.reverse

    suffix = closings.join("")

    "#{prefix}#{parse_children}#{suffix}"
  end

  def get_pr pr, node
    node.xpath(".//#{pr}/@w:val")[0].value
  rescue
    nil
  end
end
