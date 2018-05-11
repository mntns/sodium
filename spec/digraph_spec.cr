require "spec"

describe Sodium::DiGraph do
  g = Sodium::DiGraph(Int32).new()

  describe "#add_node" do
    it "adds a few nodes" do
      g.add_node(1)
      g.add_node(2)
      g.add_node(3)
      
      g.nodes.should eq((1..3).to_a)
    end
  end
end
