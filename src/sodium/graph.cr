module Sodium
  class Graph(T)
    getter :adjacency

    # Initializes graph
    def initialize()
      @adjacency = {} of T => Hash(T, Int32)
      @node = {} of T => Hash(Symbol, String)
    end

    # Adds node to graph
    def add_node(n : T, **attr)
      if !@adjacency.has_key?(n)
        @adjacency[n] = {} of T => Int32
        if !attr.empty?
          #TODO: fix .to_h in Crystal
          hacky = attr.keys.map {|k| {k => attr[k]} of Symbol => String}.to_a.reduce {|acc, i| acc.merge(i) }
          @node[n] = hacky
        else
          @node[n] = {} of Symbol => String
        end
      else
        if !attr.empty?
          hacky = attr.keys.map {|k| {k => attr[k]} of Symbol => String}.to_a.reduce {|acc, i| acc.merge(i) }
          @node[n].merge!(hacky)
        end
      end
    end

    # Add nodes from enumerable to graph
    def add_nodes_from(list)
      list.each { |node| add_node(node) }
    end

    # Removes node from graph
    def remove_node()
      # TODO
    end

    # Removes nodes given in enumerable from graph
    def remove_nodes_from()
      # TODO
    end
  
    # Adds edge to graph
    def add_edge(e : Tuple(T, T))
      e.each { |node| add_node(node) }
      @adjacency[e[0]][e[1]] = 0
      @adjacency[e[1]][e[0]] = 0
    end

    # Adds edges from list to graph
    def add_edges_from(list)
      list.each { |edge| add_edge(edge) }
    end

    # TODO: doc
    def add_weighted_edges_from()
      # TODO
    end

    # Removes edge from graph
    def remove_edge()
    end

    # Removes edges given in list from graph
    def remove_edges_from()
    end

    # Clears graph
    def clear()
    end


    # Returns all nodes in graph
    def nodes
      @node
    end

    # TODO: iterator

    # Returns all edges in graph
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

    # Returns edge data
    def get_edge_data()
    end

    # Returns neighbours of node
    def neighbours(node)
      @adjacency.fetch(node, {} of Int32 => Int32).keys()
    end

    # TODO: doc
    def adjacency()
    end






    def add_edge_weight(e : Tuple(T, T), weight : Int32) forall T
      @adjacency[e[0]][e[1]] = weight
      @adjacency[e[1]][e[0]] = weight
    end

    # Returns number of nodes inside graph
    def number_of_nodes()
      @adjacency.keys().size()
    end

    # Returns number of edges inside graph
    def number_of_edges()
      @adjacency.keys.map { |key| @adjacency[key].keys().size() }.sum() / 2
    end
  end
end
