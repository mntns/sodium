require "spec"

describe Sodium::Graph do
  g = Sodium::Graph(Int32).new()
  node_count = 0

  # -----------------------------------------
  # Adding and removing nodes and edges
  # -----------------------------------------
  
  describe "#add_node" do
    it "adds a few nodes" do
      g.add_node(1)
      g.add_node(2)
      g.add_node(3)
      node_count += 3
      
      g.nodes.keys.should eq((1..3).to_a)
    end

    it "adds some more nodes with attributes" do
      g.add_node(4, label: "label")
      g.add_node(5, shape: "box")
      g.add_node(6, weight: "1.0")
      node_count += 3
      
      g.nodes.keys.should eq((1..6).to_a)
    end
  end

  describe "#add_nodes_from" do
    it "adds nodes from array" do
      g.add_nodes_from([7, 8, 9, 10, 11, 12])
      g.add_nodes_from([13, 14, 15])
      node_count += 9

      g.nodes.keys.should eq((1..15).to_a)
    end
  end

  describe "#remove_nodes" do
    it "removes some nodes" do
      # node_count: -2
      g.remove_node(15)
      g.remove_node(14)
    end
  end

  describe "#remove_nodes_from" do
    it "removes nodes from array" do
      g.remove_nodes_from((10..13).to_a)
    end
  end

  describe "#add_edge" do
    it "adds a few edges" do
      g.add_edge(1, 2)
    end
  end

  describe "#add_edges_from" do
    it "adds edges from array" do
      g.add_edges_from([{2,3},{1,3}])
    end
  end

  describe "#add_weighted_edges_from" do
    # TODO
  end

  describe "#remove_edge" do
    # TODO
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
