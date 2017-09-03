require "spec"

describe "Sodium::Graph" do
  g = Sodium::Graph(Int32).new()
  
  describe "adding and removing nodes and edges" do
    it "adds a few nodes" do
      # node_count: 3
      g.add_node(1)
      g.add_node(2)
      g.add_node(3)
    end

    it "adds some more nodes with attributes" do
      # node_count: 3
      g.add_node(4, label: "label")
      g.add_node(5, shape: "box")
      g.add_node(6, weight: "1.0")
    end

    it "tests iterator" do
      g.each.map {|n| n}.to_a.should eq(g.nodes().keys.to_a)
    end

    it "adds nodes from array" do
      # node_count: 9
      g.add_nodes_from([7, 8, 9, 10, 11, 12])
      g.add_nodes_from([13, 14, 15])
    end

    it "removes some nodes" do
      # node_count: -2
      g.remove_node(15)
      g.remove_node(14)
    end



    it "removes nodes from array" do
      g.remove_nodes_from((10..13).to_a)
    end

    it "adds a few edges" do
      g.add_edge(1, 2)
    end

    it "adds edges from array" do
      g.add_edges_from([{2,3},{1,3}])
    end


    it "creates star" do
      # node_count: 19
      g.add_star([22, 23, 24, 25, 26, 27])
      g.neighbours(22).should eq((23..27).to_a)
    end
    
    it "creates path" do
      g.add_path([28, 29, 30, 31])
      # TODO: check for edges
    end

    it "creates cycle" do

    end

  end

  describe "iterating over nodes and edges" do
  end

  describe "information about graph structure" do
   it "checks if graph contains node" do
   end

   it "checks if graph contains edge" do
   end

   it "get order of graph" do
   end

   it "check number of nodes" do
     g.number_of_nodes().should eq(19)
   end

   it "get length of graph" do
   end

   it "get degree of graph do" do
   end

   it "iterate over degree" do
   end

   it "get size" do
   end

   it "checks number of edges" do
     g.number_of_edges().should eq(11)
   end

   it "get number of nodes that are self-looping" do
   end
  end

  describe "making copies and subgraphs" do
  end

end
