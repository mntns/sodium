module Sodium
  class Graph(T)
    include Iterator(T)
    getter :adjacency

    # Initializes graph
    def initialize()
      @name = ""
      # @graph
      @adjacency = {} of T => Hash(T, Int32)
      @node = {} of T => Hash(Symbol, String)

      @iter_idx = 0
    end

    # Converts NamedTuple to Hash
    def attr_to_h(attr)
      # TODO: Fix .to_h in Crystal for NamedTuple
      attr.keys.map {|k| {k => attr[k]} of Symbol => String}.to_a.reduce {|acc, i| acc.merge(i) }
    end

    # Iterator: Gets next item in sequence
    def next
      if @iter_idx < @node.keys.size()
        if (@node.keys[@iter_idx]?)
          @node.keys[@iter_idx]
        else
          stop
        end
        @iter_idx += 1
      else
        stop
      end
    end

    # Iterator: Rewind
    def rewind
      @iter_idx = 0
      self
    end

    # Adds node to graph
    def add_node(n : T, **attr)
      if !@adjacency.has_key?(n)
        @adjacency[n] = {} of T => Int32
        if !attr.empty?
          @node[n] = attr_to_h(attr)
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
    def add_nodes_from(list : Array(T))
      list.each { |node| add_node(node) }
    end

    # Removes node from graph
    def remove_node(n : T)
      @adjacency[n].keys.each {|u| @adjacency[u].delete(n)}
      @adjacency.delete(n)
    end

    # Removes nodes given in enumerable from graph
    def remove_nodes_from(list : Array(T))
      list.each {|node| remove_node(node)}
    end
  
    # Adds edge to graph
    def add_edge(u : T, v : T, **attr)
      #e.each { |node| add_node(node) }
      if !attr.empty?
        @adjacency[u][v] = attr_to_h(attr)
        @adjacency[v][u] = attr_to_h(attr)
      else
        @adjacency[u][v] = 0
        @adjacency[v][u] = 0
      end
    end

    # Adds edges from list to graph
    def add_edges_from(list : Array(Tuple(T, T)))
      list.each { |edge| add_edge(edge[0], edge[1]) }
    end

    # TODO: doc
    def add_weighted_edges_from()

      # TODO
    end

    # Removes edge from graph
    def remove_edge(u : T, v : T)
      @adjacency[u].delete(v)
      if u != v
        @adjacency[v].delete(u)
      end
    end

    # Removes edges given in list from graph
    def remove_edges_from(list : Array(Tuple(T, T)))
      list.each { |edge| remove_edge(edge[0], edge[1]) }
    end

    # Adds star
    def add_star(internal : T, leaves : Array(T))
    end

    # Adds path
    def add_path(nodes : Array(T))
    end

    # Adds cycle
    def add_cycle(node : Array(T))
    end

    # Clears graph
    def clear()
      @name = ""
      @adjacency.clear
      @node.clear
    end


    # Returns all nodes in graph
    def nodes
      @node
    end

    # TODO: node iterator

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

    # TODO: edge iterator

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
