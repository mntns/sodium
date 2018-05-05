require "../graph"

module Sodium
  module Generator
     class Classic(T)
      # Returns complete graph
      def complete_graph(n) 
        g = empty_graph(n)
        edges = (0...n).to_a.combinations(2).map{|e| {e[0], e[1]}}
        g.add_edges_from(edges)
        g
      end

      # Returns an empty graph
      def empty_graph(n = 0)
        g = Sodium::Graph(T).new()
        if (n != 0)
          g.add_nodes_from(0...n)
        end
        g
      end

      # Returns the path graph
      def path_graph(n)
        g = empty_graph()
        edges = (0...n).each_cons(2) do |con|
          g.add_edge(con[0], con[1])
        end
        g
      end

      # Returns the star graph
      def star_graph(n)
        g = empty_graph()
        g.add_node(0)
        edges = (1...n).map {|i| {0, i}}.to_a
        g.add_edges_from(edges)
        g
      end
    end
  end
end
