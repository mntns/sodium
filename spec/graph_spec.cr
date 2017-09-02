require "spec"

describe "Sodium::Graph" do
  g = Sodium::Graph(Int32).new()

  it "adds a few nodes" do
    g.add_node(1)
    g.add_node(2)
    g.add_node(3)
  end

  it "adds some more nodes with attributes" do
    g.add_node(4, label: "label")
    g.add_node(5, shape: "box")
    g.add_node(6, weight: "1.0")
  end

  it "adds nodes from array" do
    g.add_nodes_from([7, 8, 9, 10, 11, 12])
    g.add_nodes_from([13, 14, 15])
  end

  it "removes some nodes" do
    g.remove_node(15)
    g.remove_node(14)
  end

  it "removes nodes from array" do
    g.remove_nodes_from((10..13).to_a)
  end

  it "adds a few edges" do
    g.add_edge({1,2})
  end

  it "adds edges from array" do
    g.add_edges_from([{2,3},{1,3}])
  end

  it "checks number of nodes" do
    g.number_of_nodes().should eq(9)
  end

  it "checks number of edges" do
    g.number_of_edges().should eq(3)
  end

  it "checks neighbours for a node" do
  end

  it "checks neighbours for another node" do
  end
  
end
