require "../../spec_helper"

describe Sodium::Algorithms::Traversal::DFS do
  gen = Sodium::Generator::Classic(Int32).new()
  
  describe "#dfs_edges" do
    it "returns correct edges for complete graph" do
      graph = gen.complete_graph(10) 
      nodes = [1, 9, 8, 7, 6, 5, 4, 3, 2, 0]
      edges = nodes.each_cons(2).map {|e| {e[0], e[1]} }.to_a
      graph.dfs_edges(1).should eq(edges)
    end

    it "returns correct edges for path graph" do
      graph = gen.path_graph(10)
      nodes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
      edges = nodes.each_cons(2).map {|e| {e[0], e[1]} }.to_a
      graph.dfs_edges(1).should eq(edges)
    end
  end

  describe "#dfs_tree" do
    it "returns tree for complete graph" do
      graph = gen.complete_graph(10)
      digraph = graph.dfs_tree(1)
    end
  end
end
