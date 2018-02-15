require "active_support/all"
require "flashcard_hasher/version"
require "flashcard_hasher/card_context"
require "flashcard_hasher/token"
require "flashcard_hasher/card_parser"

module FlashcardHasher 
  
  def self.parse(file_string)
    CardParser.new(file_string).parse
  end
end
