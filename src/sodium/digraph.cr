require "./graph"

module Sodium
  class DiGraph(T) < Graph(T)
    # Add edge between u and v to digraph
    def add_edge(u : T, v : T, **attr)
      # Add nodes
      add_node(u)
      add_node(v)
      
      if !attr.empty?
        @adj[u][v] = attr_to_h(attr)
      else
        @adj[u][v] = {} of Symbol => Int32
      end
    end
    
    # Remove edge from graph
    def remove_edge(u : T, v : T)
      @adj[u].delete(v)
    end
    
    # Return number of edges
    def size
      @adj.keys.map {|k| @adj[k].keys.size() }.sum()
    end
  end
end
