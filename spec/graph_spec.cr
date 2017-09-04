require "spec"

describe Sodium::Graph do
  g = Sodium::Graph(Int32).new()

  # -----------------------------------------
  # Adding and removing nodes and edges
  # -----------------------------------------
  
  describe "#add_node" do
    it "adds a few nodes" do
      g.add_node(1)
      g.add_node(2)
      g.add_node(3)
      
      g.nodes.keys.should eq((1..3).to_a)
    end

    it "update node" do
      g.add_node(3, label: 1337)

      g.nodes[3][:label].should eq(1337)
    end

    it "adds some more nodes with attributes" do
      g.add_node(4, label: 123)
      g.add_node(5, shape: 232)
      g.add_node(6, weight: 10)
      
      g.nodes.keys.should eq((1..6).to_a)
    end
  end

  describe "#add_nodes_from" do
    it "adds nodes from array" do
      g.add_nodes_from([7, 8, 9, 10, 11, 12])
      g.add_nodes_from([13, 14, 15])
      
      g.nodes.keys.should eq((1..15).to_a)
    end
  end

  describe "#remove_nodes" do
    it "removes some nodes" do
      g.remove_node(15)
      g.remove_node(14)

      g.nodes.keys.should eq((1..13).to_a)
    end
  end

  describe "#remove_nodes_from" do
    it "removes nodes from array" do
      g.remove_nodes_from((10..13).to_a)
      
      g.nodes.keys.should eq((1..9).to_a)
    end
  end

  describe "#add_edge" do
    it "adds a few edges" do
      g.add_edge(1, 2)
      g.add_edge(2, 3)

      p g.edges.should eq([{1, 2}, {2, 3}])
    end

    it "adds an edge with weight" do
      g.add_edge(2, 3, weight: 1232)

      g.get_edge_data(2, 3).should eq({:weight => 1232})
    end

    it "adds an edge with new nodes" do
      g.add_edge(33, 34)

      g.nodes[33].should eq({} of Symbol => Int32)
    end
  end

  describe "#add_edges_from" do
    it "adds edges from array" do
      g.add_edges_from([{44, 45}, {46, 46}])
    end
  end

  describe "#add_weighted_edges_from" do
    it "adds edges with weight" do
      g.add_weighted_edges_from([{46, 47, 10}, {44, 43, 132}])
    end
  end

  describe "#remove_edge" do
    it "removes edge" do
      g.remove_edge(44, 45)
    end
  end

  describe "#remove_edges_from" do
  end

  describe "#add_star" do
    it "creates star" do
      # node_count: 19
      g.add_star([22, 23, 24, 25, 26, 27])
      g.neighbours(22).should eq((23..27).to_a)
    end
  end
    
  describe "#add_path" do
    it "creates path" do
      g.add_path([28, 29, 30, 31])
    end
    it "checks edges" do
      (28..31).each_cons(2) # .all?  
    end
  end

  describe "#add_cycle" do
    it "creates cycle" do
      # TODO
    end
  end

  # -----------------------------------------
  # Iterating over nodes and edges
  # -----------------------------------------

  describe "#nodes" do
  end

  describe "#nodes_iter" do
  end

  describe "#_iter" do
    it "tests iterator" do
      g.each.map {|n| n}.to_a.should eq(g.nodes().keys.to_a)
    end
  end

  describe "#edges" do
  end

  describe "#edges_iter" do
  end

  describe "#get_edge_data" do
  end

  describe "#neighbours" do
  end

  describe "#[]" do
  end

  describe "#adjacency_list" do
    it "gets adjacency list" do
      g.adjacency_list()
    end
  end

  describe "#adjacency_iter" do
  end

  # -----------------------------------------
  # Information about graph structure
  # -----------------------------------------

  describe "#has_node" do
  end

  describe "#[]?" do
  end

  describe "#has_edge" do
  end

  describe "#order" do
  end

  describe "#number_of_nodes" do
   it "check number of nodes" do
     g.number_of_nodes().should eq(19)
   end
  end

  describe "#degree" do
  end

  # TODO: #degree_iter

  describe "#size" do
  end

  describe "#number_of_edges" do
   it "checks number of edges" do
     g.number_of_edges().should eq(11)
   end
  end
  
  describe "#nodes_with_selfloops" do
  end

  describe "#selfloop_edges" do
  end

  describe "#number_of_selfloops" do
  end

  # -----------------------------------------
  # Making copies and subgraphs
  # -----------------------------------------

  describe "#copy" do
  end

  describe "#to_undirected" do
  end

  describe "#to_directed" do
  end

  describe "#subgraph" do
  end
end
