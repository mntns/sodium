module Sodium
  class AbstractGraph

    def initialize()
      @adjacency = {} of Int32 | String => Hash(Int32 | String, Int32)
      @node = {} of Int32 | String => Hash(Symbol, String | Int32)
    end

    def add_node(n : Int32 | String)
      if !@adjacency.has_key?(n)
        @adjacency[n] = {} of (Int32 | String) => Int32
        # @node[n] =....
      else
        # TODO: update @node weight
      end
    end

    def add_nodes_from(list)
      list.each { |node| add_node(node) }
    end

    def add_edge(e : Tuple(Int32 | String, Int32 | String))
      e.each { |node| add_node(node) }
      @adjacency[e[0]][e[1]] = 0
      @adjacency[e[1]][e[0]] = 0
    end

    def add_edges_from(list)
      list.each { |edge| add_edge(edge) }
    end

    def nodes()
      @adjacency.keys()
    end

    def debug()
      @adjacency
    end

    def edges()
      #TODO: This has to be more elegant
      hash = Hash.zip(@adjacency.keys, @adjacency.keys.map {|k| @adjacency[k].keys() })
      hash.reject {|k, v| v.empty?}.map {|k, v| v.map {|i| {k, i} } }.flatten()
    end

    def neighbours(node)
      @adjacency.fetch(node, {} of Int32 => Int32).keys()
    end

    def clear()
      #TODO: Is this even legal?
      initialize()
    end

    def number_of_nodes()
      @adjacency.keys().size()
    end

    def number_of_edges()
      @adjacency.keys.map { |key| @adjacency[key].keys().size() }.sum() / 2
    end
  end
end
