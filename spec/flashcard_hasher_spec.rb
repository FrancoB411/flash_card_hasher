RSpec.describe FlashcardHasher do
  it "has a version number" do
    expect(FlashcardHasher::VERSION).not_to be nil
  end

  let(:markdown_input) { File.read('spec/fixtures/sample_input.md') }

  describe "::parse" do

    it "turns sample notes into a hash of nested flashcards" do
      card_parser = instance_double("CardParser") 
      expect(CardParser).to receive(:new).with(markdown_input).and_return(card_parser)
      expect(card_parser).to receive(:parse)
      FlashcardHasher.parse(markdown_input)
    end
  end

end
