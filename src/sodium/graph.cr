module Sodium
  class Graph
    def initialize
      @adjacency = {} of Int32 | String => Hash(Int32 | String, Int32)
      @node = {} of Int32 | String => Hash(Symbol, Int32 | String)
    end

    def add_node(n : Int32 | String, **attr)
      if !@adjacency.has_key?(n)
        @adjacency[n] = {} of Int32 | String => Int32
        if !attr.empty?
          #TODO: fix .to_h in Crystal
          hacky = attr.keys.map {|k| {k => attr[k]} of Symbol => Int32 | String}.to_a.reduce {|acc, i| acc.merge(i) }
          @node[n] = hacky
        else
          @node[n] = {} of Symbol => Int32 | String
        end
      else
        if !attr.empty?
          hacky = attr.keys.map {|k| {k => attr[k]} of Symbol => Int32 | String}.to_a.reduce {|acc, i| acc.merge(i) }
          @node[n].merge!(hacky)
        end
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
      @node
    end

    def debug()
      @adjacency
    end

    def edges()
      seen = {} of Int32 | String => Int32
      arr = [] of Tuple(Int32 | String, Int32 | String)
      @adjacency.each do |k, v|
        v.each do |subk, subv|
          if !seen.has_key?(subk)
            arr << {k, subk}
          end
        end
        seen[k] = 1
      end
      arr
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
