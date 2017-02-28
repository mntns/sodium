require "./graph"

module Sodium
  class Generator
    def initialize
      @random = Random.new
    end

    def simple_random(c_nodes, c_edges)
      g = Sodium::Graph.new()

      g.add_node(0)

      (1..c_nodes).each do |i|
        g.add_node(i)
        g.add_edge({i, @random.rand(g.number_of_nodes() - 1)})
      end
      return g
    end

  end
end
