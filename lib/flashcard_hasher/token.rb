class Token
  attr_accessor :string, :previous, :next

  def initialize(string)
    @string = string
    @previous = NullToken.new
    @next = NullToken.new
  end

  def is_heading?
    pound_signs_followed_by_spaces = /(^#+\s)(.+)/
    !!string.match(pound_signs_followed_by_spaces)
  end

  def level
    number_of_pound_signs = /(^#+\s)/
    string.match(number_of_pound_signs)[1].strip.length if is_heading?
  end

  def value
    after_the_pound_signs = /(^#+\s)(.+)/
    string.match(after_the_pound_signs)[2]
  end

  def is_definition?
    return false if blank?

    if starts_with_squiggle? or previous.is_definition?
      true 
    else
      false
    end
  end

  def is_term?
    !is_heading? && self.next.is_definition?
  end

  def starts_with_squiggle?
    !!string.match(/\s{2}[~]/)
  end

  def blank?
    self.string.blank?
  end

  def is_last_line_of_definition?
    is_definition? and (self.last? or self.next.blank?)
  end
  
  def last?
    self.next.class == NullToken
  end
end


class NullToken 
  def method_missing(symbol, *args, &block)
    false
  end
end

