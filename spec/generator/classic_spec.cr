require "../spec_helper"

describe Sodium::Generator::Classic do
  gen = Sodium::Generator::Classic(Int32).new()
  n = 10
  
  it "generates complete graph" do
    g = gen.complete_graph(n)
    edges = (0...n).to_a.combinations(2).map{|e| {e[0], e[1]}}
    g.edges.should eq(edges)
  end

  it "generates empty graph with default values" do
    g = gen.empty_graph()
    g.nodes.should eq([] of Int32)
  end

  it "generates empty graph with 10 nodes" do
    g = gen.empty_graph(n)
    g.nodes.should eq((0...n).to_a)
  end

  it "generates path graph" do
    g = gen.path_graph(n)
    edges = (0...n).each_cons(2).map{|e| {e[0], e[1]}}.to_a
    g.edges.should eq(edges)
  end

  it "generates star graph" do
    g = gen.star_graph(n)
    edges = (1...n).map{|i| {0, i}}
    g.edges.should eq(edges)
  end

end
