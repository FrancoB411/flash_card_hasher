class CardParser 

  attr_reader :file_string, :tokens

  def initialize file_string
    @file_string = file_string
    @tokens = tokenize(file_string)
  end

  def parse
    context = CardContext.new(level:0) 
    card = blank_card 

    tokens.each do |token|

      if token.is_heading?
        if token.level > context.level
          child = CardContext.new(level: token.level, heading: token.value)
          context.add_child(child)
          context = child
        elsif token.level == context.level
          sibling = CardContext.new(level: token.level, heading: token.value)
          context.parent.add_child(sibling)
          context = sibling
        else
          while token.level <= context.level
            context = context.parent
          end

          child = CardContext.new(level: token.level, heading: token.value)
          context.add_child(child)
          context = child
        end
      end

      if token.is_term?
        card["front"] = token.string
      end

      if token.is_definition? 
        card["back"] = card["back"] + token.string + "\n"

        if token.is_last_line_of_definition?
          context.cards << card
          card = blank_card
        end
      end
    end
    context.root.process
  end

  def blank_card
    { "front" => "", "back" => "" }
  end

  def tokenize string
    tokens = string.split("\n").map { |t| Token.new t }

    tokens.each_with_index.map do |t, i|
      t.previous = tokens[i - 1] unless i == 0
      t.next = tokens[i + 1] unless i + 1 == tokens.length 
    end

    tokens
  end
end

