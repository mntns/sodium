require "../graph"

module Sodium
  module Generator
     module Classic(T)

      # Returns complete graph
      def complete_graph(n) 
        g = empty_graph(n)
        edges = (0..n).to_a.combinations(2).map{|e| {e[0], e[1]}}
        g.add_edges_from(edges)
        g
      end

      # Returns an empty graph
      def empty_graph(n = 0)
        g = Sodium::Graph(T).new()
        g.add_nodes_from((0..n).to_a)
        g
      end

    end
  end
end
