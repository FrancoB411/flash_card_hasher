RSpec.describe Token, type: :model do

  levels = ["# heading", "## heading", "### heading", "#### heading", "##### heading", "###### heading"]

  lines = [
    "# h1",
    "A term",
    "  ~ A definition"
  ]

  describe "#level" do
    levels.each_with_index do |heading, index|
      it "returns level #{index +1} when given #{heading} " do
        token = Token.new(heading)
        expect(token.level).to eq(index +1)
      end
    end
  end

  describe "#value" do
    levels.each do |heading|
      it "returns #{heading} without the pound Sign" do
        token = Token.new(heading)
        value = heading.match(/(^#+\s)(.+)/)[2]
        expect(token.value).to eq value
      end
    end
  end

  describe "#is_heading?" do
    levels.each do |heading|
      it "#{heading} returns true because it's a heading" do
        token = Token.new(heading) 
        expect(token.is_heading?).to be true
      end
    end

    non_levels = ["plaing text"]

    non_levels.each do |heading|
      it "returns false when #{heading}" do 
        token = Token.new(heading) 
        expect(token.is_heading?).to be false
      end
    end
  end


  lines.each_with_index do |line, index|
    previous = lines[index - 1] 
    nextLine = lines[index + 1] 
    token = Token.new(line)
    token.previous = previous 
    token.next = nextLine 

    describe "#previous" do 
      it "stores the previous line in the array" do 
        expect(token.previous).to eq(previous)
      end
    end

    describe "#next" do 
      it "stores the next line in the array" do 
        expect(token.next).to eq(nextLine)
      end
    end
  end

  describe "#is_term?" do
    file = File.read('spec/fixtures/sample_import.md')
    tokens = file.split("\n").map{|line| Token.new(line) }

    it "returns true when is a term" do
      token = Token.new("a term") 
      token.previous = Token.new(" ")
      token.next = Token.new("  ~ anything")
      allow(token.next).to receive(:is_definition) {true}

      expect(token.is_heading?).to be false
      expect(token.next.is_definition?).to be true
      expect(token.is_term?).to be true
    end

    it "false when is a heading" do
      token = Token.new("# a heading") 
      expect(token.is_heading?).to be true
      expect(token.is_term?).to be false
    end

    it "false when next line is not definition" do
      token = Token.new("a term") 
      token.previous = Token.new(" ")
      token.next = Token.new("not a definition")
      expect(token.is_heading?).to be false
      expect(token.next.is_definition?).to be false
      expect(token.is_term?).to be false
    end

  end

  describe "#is_definition" do
    context "starts with a squiggle" do
      it "true" do
        token = Token.new("  ~ a definition")

        expect(token.starts_with_squiggle?).to be true
        expect(token.is_definition?).to be true
      end
    end

    context "does not start with a squiggle" do
      it "can't be blank?" do 
        token = Token.new('')
        expect(token.is_definition?).to be false
      end

      it "true when previous is definition" do
        token = Token.new("anything")
        token.previous = Token.new("  ~ definition")
        allow(token.previous).to receive(:is_definition) {true}
        expect(token.is_definition?).to be true
      end

      it "is false otherwise" do 
        token = Token.new('')
        expect(token.is_definition?).to be false
      end
    end
  end

  describe "#starts_with_squiggle?" do 
    context "starts with squiggle" do
      subject { Token.new("  ~") }
      its(:starts_with_squiggle?) { is_expected.to be true }
    end
    context "does not start with squiggle" do
      subject { Token.new("not a squiggle") }
      its(:starts_with_squiggle?) { is_expected.to be false }
    end
  end

  describe "#blank?" do
    context "empty string" do
      subject { Token.new('') }
      its(:blank?) { is_expected.to be true }
    end

    context "string just spaces" do
      subject { Token.new('    ') }
      its(:blank?) { is_expected.to be true } 
    end

    context "anything in the string" do
      subject { Token.new('    anything   ') }
      its(:blank?) { is_expected.to be false }
    end
  end


  describe "#is_last_line_of_definition?" do
    subject { Token.new("some content") }

    context "when not a definition" do 
      before { allow(subject).to receive(:is_definition?) { false } }

      its(:is_last_line_of_definition?) { is_expected.to be false }
    end

    context "when definition" do
      before { allow(subject).to receive(:is_definition?) { true } }

      context "and next is blank" do 
        let(:nnext) { Token.new("") }
        its(:is_last_line_of_definition?) { is_expected.to be true }
      end

      context "is last token" do 
        its(:is_last_line_of_definition?) { is_expected.to be true }
      end
    end
  end


end

