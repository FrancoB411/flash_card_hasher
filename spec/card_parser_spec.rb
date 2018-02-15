RSpec.describe CardParser, type: :model do
  let(:md) { File.read('spec/fixtures/sample_input.md') }
  let(:parsed) { JSON.parse(File.read('spec/fixtures/sample_output.json')) }

  subject { CardParser.new(md) }

  its(:file_string) { is_expected.to eq(md) }
  its(:parse) { is_expected.to eq(parsed) }

  # TODO break up some #parse logic into #update_current_context method
  describe "#update_current_context" do
    context "when child heading" do
      it "adds a subcontext" do
      end
      it "makes new context the current context" do
      end
    end
    context "when sibling heading" do
      it "adds a sibling context" do
      end
      it "make new context the current context" do
      end
    end
    context "when parent heading" do
      it "adds a context to the parent context list" do
      end
      it "makes new context the current_context" do
      end
    end
  end

  describe "#blank_card" do
    its(:blank_card) { is_expected.to eq({ "front" => "", "back" => "" }) }
  end

  describe "#tokenize" do 
    file_string = "# heading1\nterm1\n  ~ definition1"
    tokens = CardParser.new(file_string).tokens 

    it "turns a string into a list of tokens" do
      tokens.each { |t| expect(t).to be_a Token }
    end

    it "breaks string along newlines" do
      expect(tokens.first.string).to eq "# heading1"
      expect(tokens.second.string).to eq "term1"
      expect(tokens.last.string).to eq "~ definition1"
    end

    it "links previous and next tokens" do
      expect(tokens.first.previous).to be_a NullToken 
      expect(tokens.first.next.string).to eq "term1"

      expect(tokens.second.previous.string).to eq "# heading1" 
      expect(tokens.second.next.string).to eq "~ definition1"

      expect(tokens.third.previous.string).to eq "term1" 
      expect(tokens.third.next).to be_a NullToken 
    end
  end

end
