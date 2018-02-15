
RSpec.describe CardContext, type: :model do
  its(:heading) { is_expected.to eq(nil) }
  its(:cards) { is_expected.to eq([]) }
  its(:level) { is_expected.to be nil }
  its(:children) { is_expected.to eq([]) }

  describe "#add_child" do
    let(:child) { CardContext.new }
    before { subject.add_child(child) }

    it "adds a CardContext to the list of children" do
      expect(subject.children.first).to eq child
    end

    it "child CardContext's #parent method points to self" do
      expect(subject.children.first.parent).to eq subject
    end
  end

  context "with no parent" do
    its(:parent){ is_expected.to be nil }
  end

  context "with parent" do
    let(:parent) { CardContext.new }
    subject { CardContext.new(parent: parent) }

    it "Parent is type CardContext" do
      expect(subject.parent.class).to eq CardContext
    end

    it "lives in parent's children" do
      expect(subject.parent.children).to include(subject)
    end
  end

  context "with no children" do
    its(:children) { is_expected.to eq [] }
  end

  context "with children" do
    let(:child) { CardContext.new }
    before { subject.add_child(child) }

    its(:children) { is_expected.to include(child) }

    it "each child's parent points to self" do
      expect(child.parent).to be(subject)
    end
  end

  describe "#process" do
    let(:grand_child) { CardContext.new(heading: "grand_child") }
    let(:child) { CardContext.new(heading: "child") }
    let(:processed) {
      { 
        "heading" =>  "parent",
        "cards" => [
        ],
        "contexts" => [
          {
            "heading" => "child",
            "cards" => [
            ],
            "contexts" => [
              {
                "heading" => "grand_child",
                "cards" => [
                ],
                "contexts" => [
                ]
              }
            ]
          }
        ]
      }
    }
    subject { CardContext.new(heading: "parent") }

    before { 
      child.add_child(grand_child)
      subject.add_child(child) 
    }

    it "recursively turns children to hashes" do
      expect(subject.process).to eq processed 
    end
  end

  describe "#is_root?" do
    context "when root" do
      subject { CardContext.new(level: 0) }
      its(:is_root?) { is_expected.to be true }
    end

    context "when not root" do
      subject { CardContext.new(level: 1) }
      its(:is_root?) { is_expected.to be false }
    end
  end

  describe "#root" do
    let(:grand_child) { CardContext.new(heading: "grand_child", level: 2) }
    let(:child) { CardContext.new(heading: "child", level: 1) }
    subject { CardContext.new(heading: "root", level: 0) }

    before { 
      child.add_child(grand_child)
      subject.add_child(child) 
    }
    it "returns the root object" do
      expect(grand_child.root).to eq(subject)
      expect(child.root).to eq(subject)
      expect(subject.root).to eq(subject)
    end
  end


end

