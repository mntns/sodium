module Sodium
  class Graph(T)
    include Iterator(T)

    # Initializes graph
    def initialize
      @adj = {} of T => Hash(T, Hash(Symbol, Int32))
      @node = {} of T => Hash(Symbol, Int32)

      @iter_idx = 0
    end

    # Converts NamedTuple to Hash
    def attr_to_h(attr)
      # TODO: Fix .to_h in Crystal for NamedTuple
      if !attr.empty?
        attr.keys.map {|k| {k => attr[k]} of Symbol => Int32}.to_a.reduce {|acc, i| acc.merge(i) }
      else
        {} of Symbol => Int32
      end
    end

    # Adds node to graph
    def add_node(n : T, **attr)
      if !@adj.has_key?(n)
        @adj[n] = {} of T => Hash(Symbol, Int32)
        @node[n] = attr_to_h(attr)
      else
        @node[n].merge!(attr_to_h(attr))
      end
    end

    # Add nodes from enumerable to graph
    def add_nodes_from(list : Array(T))
      list.each { |node| add_node(node) }
    end

    # Removes node from graph
    def remove_node(n : T)
      @adj[n].keys.each {|u| @adj[u].delete(n)}
      @adj.delete(n)
      @node.delete(n)
    end

    # Removes nodes given in enumerable from graph
    def remove_nodes_from(list : Array(T))
      list.each {|node| remove_node(node)}
    end
  
    # Adds edge to graph
    def add_edge(u : T, v : T, **attr)
      # Add nodes
      add_node(u)
      add_node(v)
      
      if !attr.empty?
        @adj[u][v] = attr_to_h(attr)
        @adj[v][u] = attr_to_h(attr)
      else
        @adj[u][v] = {} of Symbol => Int32
        @adj[v][u] = {} of Symbol => Int32
      end
    end

    # Adds edges from list to graph
    def add_edges_from(list : Array(Tuple(T, T)))
      list.each { |e| add_edge(e[0], e[1]) }
    end

    # Adds weighted edges from list
    def add_weighted_edges_from(list : Array(Tuple(T, T, Int32)))
      list.each { |e| add_edge(e[0], e[1], weight: e[2]) }
    end

    # Removes edge from graph
    def remove_edge(u : T, v : T)
      @adj[u].delete(v)
      if u != v
        @adj[v].delete(u)
      end
    end

    # Removes edges given in list from graph
    def remove_edges_from(list : Array(Tuple(T, T)))
      list.each { |edge| remove_edge(edge[0], edge[1]) }
    end

    # Adds star
    def add_star(nodes : Array(T))
      edges = nodes[1..-1].map {|n| {nodes[0], n}}
      add_edges_from(edges)
    end

    # Adds path
    def add_path(nodes : Array(T))
      edges = nodes.each_cons(2).map {|c| Tuple(T, T).from(c)}
      add_edges_from(edges.to_a)
    end

    # Adds cycle
    def add_cycle(nodes : Array(T))
      add_path(nodes)
      add_edge(nodes[-1], nodes[0])
    end

    # Clears graph
    def clear()
      @adj.clear
      @node.clear
    end

    # Returns all nodes in graph
    def nodes
      @node
    end

    # `Iterator`: Get next node
    def next
      # TODO: node and edge iterator
      if @iter_idx < @node.keys.size()
        if (@node.keys[@iter_idx]?)
          @iter_idx += 1
          @node.keys[@iter_idx-1]
        else
          stop
        end
      else
        stop
      end
    end

    # `Iterator`: Rewind
    def rewind
      @iter_idx = 0
      self
    end
    
    # Returns all edges in graph
    def edges
      seen = {} of Int32 | String => Int32
      arr = [] of Tuple(Int32 | String, Int32 | String)
      @adj.each do |k, v|
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
    def get_edge_data(u : T, v : T)
       @adj[u][v]
    end

    # Returns neighbours of node
    def neighbours(node)
      # TODO: Int32?
      @adj.fetch(node, {} of Int32 => Int32).keys()
    end

    # Returns an adjacency list in order of nodes()
    def adjacency_list()
      @adj.map {|k, v| v.keys()}
    end

    def add_edge_weight(e : Tuple(T, T), weight : Int32) forall T
      @adj[e[0]][e[1]] = weight
      @adj[e[1]][e[0]] = weight
    end

    # Returns number of nodes inside graph
    def number_of_nodes()
      @adj.keys().size()
    end

    # Returns number of edges inside graph
    def number_of_edges()
      @adj.keys.map { |key| @adj[key].keys().size() }.sum() / 2
    end
  end
end
