require "../../graph"
require "../../digraph"

module Sodium::Algorithms::Traversal
  module DFS(T)

    # Returns edges produced in depth-first traversal
    def dfs_edges(source)
      visited = Set(T).new
      stack = Array(T).new

      stack << source

      while !stack.empty?
        node = stack.pop

        if !visited.includes?(node)
          visited << node
        end

        self.neighbours(node).each do |neighbour|
          if !visited.includes?(neighbour)
            stack << neighbour
          end
        end
      end

      visited.each_cons(2).map {|i| {i[0], i[1]} }.to_a
    end
    
    # Returns tree produced by dept-first search
    def dfs_tree(source)
      digraph = DiGraph(T).new
      edges = self.dfs_edges(source)
      digraph.add_edges_from(edges)
      digraph
    end

  end
end
