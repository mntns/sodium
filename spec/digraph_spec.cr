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

    it "adds some more nodes with attributes" do
      g.add_node(4, label: 123)
      g.add_node(5, shape: 232)
      g.add_node(6, weight: 10)
      
      g.nodes.should eq((1..6).to_a)
    end
  end

  describe "#add_edges_from" do
    it "adds edges from array" do
      g.add_edges_from([{44, 45}, {46, 46}])
    end
  end

  describe "#number_of_edges" do
   it "checks number of edges for list of nodes" do
     g.number_of_edges([{1,2}, {45,44}, {44,45}]).should eq(1)
   end
  end

end
