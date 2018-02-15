RSpec.describe FlashcardHasher do
  it "has a version number" do
    expect(FlashcardHasher::VERSION).not_to be nil
  end

  it "does something useful" do
    actual = FlashcardHasher.parse('# foo')
    expected = {"heading"=>nil, "cards"=>[], "contexts"=>[{"heading"=>"foo", "cards"=>[], "contexts"=>[]}]}
    expect(actual).to eq(expected)
  end
end
