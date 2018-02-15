class CardContext

  attr_accessor :heading, 
                :cards, 
                :children, 
                :parent, 
                :level

  def initialize(parent: nil, heading: nil, cards: [], level: nil)
    @parent = parent
    @cards = cards
    @heading = heading
    @children = []
    @level = level
    parent.add_child(self) if parent
  end

  def add_child(context)
    context.parent = self
    self.children << context
    self
  end

  def process
    to_h 
  end

  def to_h
    {
      "heading" => heading,
      "cards" => cards,
      "contexts" => children.map(&:process)
    }
  end

  def is_root?
    level == 0
  end

  def root
    is_root? ? self : parent.root 
  end
end

