require "spec"

describe "Sodium::Graph" do
  g = Sodium::Graph(Int32).new()

  it "adds a few nodes" do
    g.add_node(1)
    g.add_node(2)
    g.add_node(3)
  end

  it "adds some more nodes" do
    g.add_node(5, label: "label")
    g.add_node(4, shape: "box")
    g.add_node(3, weight: "1.0")
  end

  it "adds nodes from array" do
    g.add_nodes_from([4, 5, 6])
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
  end

  it "checks neighbours for a node" do
  end

  it "checks neighbours for another node" do
  end
  
end
