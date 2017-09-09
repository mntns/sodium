module Sodium
  class Graph(T)
    include Iterator(T)

    # Initialize empty graph
    def initialize
      @adj = {} of T => Hash(T, Hash(Symbol, Int32))
      @node = {} of T => Hash(Symbol, Int32)

      @iter_idx = 0
    end

    # :nodoc:
    # Converts NamedTuple to Hash
    def attr_to_h(attr)
      # TODO: Fix .to_h in Crystal for NamedTuple
      if !attr.empty?
        attr.keys.map {|k| {k => attr[k]} of Symbol => Int32}.to_a.reduce {|acc, i| acc.merge(i) }
      else
        {} of Symbol => Int32
      end
    end

    # Add node to graph or update node attributes
    def add_node(n : T, **attr)
      if !@adj.has_key?(n)
        @adj[n] = {} of T => Hash(Symbol, Int32)
        @node[n] = attr_to_h(attr)
      else
        @node[n].merge!(attr_to_h(attr))
      end
    end

    # Add nodes from array to graph
    def add_nodes_from(list : Array(T))
      list.each { |node| add_node(node) }
    end

    # Remove node from graph
    def remove_node(n : T)
      @adj[n].keys.each {|u| @adj[u].delete(n)}
      @adj.delete(n)
      @node.delete(n)
    end

    # Remove nodes given in array from graph
    def remove_nodes_from(list : Array(T))
      list.each {|node| remove_node(node)}
    end
  
    # Add edge between u and v to graph
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

    # Add edges from array to graph
    def add_edges_from(list : Array(Tuple(T, T)))
      list.each { |e| add_edge(e[0], e[1]) }
    end

    # Add weighted edgres from array of form (u, v, weight) to graph
    def add_weighted_edges_from(list : Array(Tuple(T, T, Int32)))
      list.each { |e| add_edge(e[0], e[1], weight: e[2]) }
    end

    # Remove edge from graph
    def remove_edge(u : T, v : T)
      @adj[u].delete(v)
      if u != v
        @adj[v].delete(u)
      end
    end

    # Remove edges given in array from graph
    def remove_edges_from(list : Array(Tuple(T, T)))
      list.each { |edge| remove_edge(edge[0], edge[1]) }
    end

    # Add star to graph (first node in array is center)
    def add_star(nodes : Array(T))
      edges = nodes[1..-1].map {|n| {nodes[0], n}}
      add_edges_from(edges)
    end

    # Add path of nodes to graph
    def add_path(nodes : Array(T))
      edges = nodes.each_cons(2).map {|c| Tuple(T, T).from(c)}
      add_edges_from(edges.to_a)
    end

    # Add cycle to graph
    def add_cycle(nodes : Array(T))
      add_path(nodes)
      add_edge(nodes[-1], nodes[0])
    end

    # Clear graph
    def clear()
      @adj.clear
      @node.clear
    end

    # Return all nodes in graph
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
    
    # Return all edges in graph
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

    # Return associated data of specified edge
    def get_edge_data(u : T, v : T)
       @adj[u][v]
    end

    # Return neighbours of node
    def neighbours(node)
      # TODO: Int32?
      @adj.fetch(node, {} of Int32 => Int32).keys()
    end

    # Return adjacency list in order of #nodes()
    def adjacency_list()
      @adj.map {|k, v| v.keys()}
    end

    # Check if graph contains node
    def has_node?(node : T)
      !(@node[node]?.is_nil?)
    end

    # Check if graph contains node
    def []?(node : T)
      has_node?(node)
    end

    # Check if graph contains edge
    def has_edge?(u : T, v : T)
      !(@node[u][v]?.is_nil?)
    end

    # Return order of graph
    def order
      @node.size()
    end

    # Return number of nodes in graph
    def number_of_nodes
      order()
    end

    # Return degree of node
    def degree(node : T)
    end

    # Return number of edges
    def size
      @adj.keys.map { |key| @adj[key].keys().size() }.sum() / 2
    end

    # Return number of edges between nodes
    def number_of_edges(list : Array(Tuple(T, T)))
    end

    # Return nodes with self loop
    def nodes_with_selfloops
    end

    # Return edges with self loops
    def selfloop_edges
    end

    # Return number of edges with self loops
    def number_of_selfloops
    end
    
    # Return shallow copy of graph
    def copy
      self.dup
    end
  end
end
