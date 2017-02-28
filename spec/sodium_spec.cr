require "./spec_helper"

describe Sodium do
  it "does something" do
    true.should eq(true)
  end
  
  g = Sodium::Graph.new()

  it "adds a few nodes" do
    g.add_node(1)
    g.add_node(2)
    g.add_node(3)
  end

  it "adds some more nodes" do
    g.add_node("homer", label: "label")
    g.add_node("marge", shape: "box")
    g.add_node("bart", weight: "1.0")
  end

  it "adds nodes from array" do
    g.add_nodes_from([4, 5, 6])
    g.add_nodes_from(["lisa", "maggie", "flanders"])
  end

  it "adds a few edges" do
    g.add_edge({1,2})
    g.add_edge({"homer", "marge"})
  end

  it "adds edges from array" do
    g.add_edges_from([{2,3},{1,3}])
    g.add_edges_from([{"flanders","homer"}, {"bart","lisa"}])
  end

  it "checks number of nodes" do
    g.number_of_nodes().should eq(12)
  end

  it "checks number of edges" do
    g.number_of_edges().should eq(6)
  end

  it "checks neighbours for a node" do
    g.neighbours(1).should eq([2, 3])
  end

  it "checks neighbours for another node" do
    g.neighbours("homer").should eq(["marge", "flanders"])
  end
  
  dot = Sodium::Dot.new()
  gen = Sodium::Generator.new()
  dot.write_dot(gen.simple_random(100, 50), "test.dot")
  dot.write_dot(g, "test2.dot")
end
