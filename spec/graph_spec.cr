require "spec"

describe Sodium::Graph do
  g = Sodium::Graph(Int32).new()

  describe "#add_node" do
    it "adds a few nodes" do
      g.add_node(1)
      g.add_node(2)
      g.add_node(3)
      
      g.nodes.should eq((1..3).to_a)
    end

    it "update node" do
      g.add_node(3, label: 1337)

      g.nodes_with_data[3][:label].should eq(1337)
    end

    it "adds some more nodes with attributes" do
      g.add_node(4, label: 123)
      g.add_node(5, shape: 232)
      g.add_node(6, weight: 10)
      
      g.nodes.should eq((1..6).to_a)
    end
  end

  describe "#add_nodes_from" do
    it "adds nodes from array" do
      g.add_nodes_from([7, 8, 9, 10, 11, 12])
      g.add_nodes_from([13, 14, 15])
      
      g.nodes.should eq((1..15).to_a)
    end
  end

  describe "#remove_nodes" do
    it "removes some nodes" do
      g.remove_node(15)
      g.remove_node(14)

      g.nodes.should eq((1..13).to_a)
    end
  end

  describe "#remove_nodes_from" do
    it "removes nodes from array" do
      g.remove_nodes_from((10..13).to_a)
      
      g.nodes.should eq((1..9).to_a)
    end
  end

  describe "#add_edge" do
    it "adds a few edges" do
      g.add_edge(1, 2)
      g.add_edge(2, 3)

      g.edges.should eq([{1, 2}, {2, 3}])
    end

    it "adds an edge with weight" do
      g.add_edge(2, 3, weight: 1232)

      g.get_edge_data(2, 3).should eq({:weight => 1232})
    end

    it "adds an edge with new nodes" do
      g.add_edge(33, 34)

      g.nodes_with_data[33].should eq({} of Symbol => Int32)
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
      edges_before = g.edges()
      g.remove_edge(44, 45)
      g.edges().should eq(edges_before - [{44, 45}])
    end
  end

  describe "#remove_edges_from" do
    it "remove edges from array" do
      edges_before = g.edges()
      g.remove_edges_from([{46, 47}, {44, 43}])
      g.edges().should eq(edges_before - [{46, 47}, {44, 43}])
    end
  end

  describe "#add_star" do
    it "creates star" do
      g.add_star([22, 23, 24, 25, 26, 27])
      g.neighbours(22).should eq((23..27).to_a)
    end
  end
    
  describe "#add_path" do
    it "creates path" do
      g.add_path([28, 29, 30, 31])
      (28..31).each_cons(2).map {|e| g.has_edge?(e[0], e[1]) }.all?.should be_true
    end
  end

  describe "#add_cycle" do
    it "creates cycle" do
      g.add_cycle([31, 32, 33, 34])
      (31..34).each_cons(2).map {|e| g.has_edge?(e[0], e[1]) }.all?.should be_true
    end
    it "checks closing edge" do
      g.has_edge?(31, 34).should be_true
    end
  end


  describe "#nodes" do
    it "checks if nodes are right" do
      g.nodes.should eq([1, 2, 3, 4, 5, 6, 7, 8, 9, 
                         33, 34, 44, 45, 46, 47, 43, 
                         22, 23, 24, 25, 26, 27, 28, 
                         29, 30, 31, 32])
    end
  end

  describe "#_iter" do
    it "collects and compares nodes from iterator" do
      g.each.map {|n| n}.to_a.should eq(g.nodes.to_a)
    end
  end

  describe "#edges" do
    it "checks edges" do
      g.edges.should eq([{1, 2}, {2, 3}, {33, 34}, 
                         {33, 32}, {34, 31}, {46, 46}, 
                         {22, 23}, {22, 24}, {22, 25}, 
                         {22, 26}, {22, 27}, {28, 29}, 
                         {29, 30}, {30, 31}, {31, 32}])
    end
  end

  describe "#get_edge_data" do
    it "check edge data for existent edge" do
      g.get_edge_data(2, 3).should eq({:weight => 1232})
    end
    it "check edge data for non-existent edge" do
      g.get_edge_data(99, 31).should eq({} of Symbol => Int32)
    end
  end

  describe "#neighbours" do
    it "checks neighbours of existent node" do
      g.neighbours(1).should eq([2])
    end
    it "check neighbours of non-existent node" do
      g.neighbours(99).should eq([] of Int32)
    end
  end

  describe "#[]" do
    it "gets node from graph" do
      g[3].should eq({:label => 1337})
    end
    it "gets non-existing node from graph" do
      # TODO
    end
  end

  describe "#adjacency_list" do
    it "gets adjacency list" do
      #p g.adjacency_list()
      # TODO
    end
  end
 

  describe "#has_node?" do
    it "check if graph has node that exists" do
      g.has_node?(1).should be_true
    end

    it "check if graph has node that doesn't exist" do
      g.has_node?(999).should be_false
    end
  end

  describe "#[]?" do
    it "check if graph has node that exists" do
      g[3]?.should eq({:label => 1337})
    end

    it "check if graph has node that doesn't exist" do
      g[999]?.should be_nil
    end
  end

  describe "#has_edge?" do
    it "checks existent edge" do
      g.has_edge?(1, 2).should be_true
    end

    it "checks non-existent edge" do
      g.has_edge?(32, 43).should be_false
    end
  end

  describe "#order" do
    it "checks order of graph" do
      g.order.should eq(27)
    end
  end

  describe "#number_of_nodes" do
   it "check number of nodes" do
     g.number_of_nodes.should eq(27)
   end
  end

  describe "#degree" do
    it "checks degree of node" do
      g.degree(1).should eq(1)
    end
  end

  describe "#size" do
    it "checks number of edges" do
      g.size.should eq(14)
    end
  end

  describe "#number_of_edges" do
   it "checks number of edges for list of nodes" do
     g.number_of_edges([{1,2}, {2,3}, {55,66}]).should eq(2)
   end
  end
  
  describe "#nodes_with_selfloops" do
    it "gets nodes with self loops" do
      g.nodes_with_selfloops().should eq([46])
    end
  end

  describe "#selfloop_edges" do
    it "gets edges that self-loop" do
      g.selfloop_edges.should eq([{46, 46}])
    end
  end

  describe "#number_of_selfloops" do
    it "get number of selfloops" do
      g.number_of_selfloops.should eq(1)
    end
  end

  
  describe "#copy" do
    it "checks if copy of graph is new object" do
      g2 = g.copy
      (g2 != g).should be_true
    end
  end

  describe "#to_undirected" do
    # TODO
  end

  describe "#to_directed" do
    # TODO
  end

  describe "#subgraph" do
    # TODO
  end

  describe "#/" do
    h = Sodium::Graph(Int32).new
    h.add_nodes_from((1..5))
    h.add_edges_from([{1,2}, {2,3}, {3,4}, {4,5}, {5,1}, {1,3}, {3,5}])
    quot = h / { 10 => [1,2], 20 => [3,4] }

    it "returns a Graph with aggregated nodes" do
      quot.nodes.to_set.should eq(Set{10, 20, 5})
    end

    it "preserves edges" do
      quot.has_edge? 10, 20
      quot.has_edge? 20, 5
      quot.has_edge? 5, 10
    end

    it "does not introduce spurious edges" do
      quot.edges.size.should eq(3)
    end
  end
end
