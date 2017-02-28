require "./graph"

module Sodium
  class Dot
    def initialize
      # TODO: check for dot binary
    end

    def gen_attributes(attr)
      if !attr.empty?
        attr.map {|k,v| "#{k}=\"#{v}\""}.join(",")
      end
    end

    def generate_dot(graph)
      nodes = graph.nodes()
      edges = graph.edges()
      dot = ""

      dot += "graph {\n"
      nodes.each do |k, v|
        dot += "  #{k}[#{gen_attributes(v)}]\n"
      end

      edges.each do |edge|
        dot += "  #{edge[0]} -- #{edge[1]}\n"
      end

      dot += "}\n"
    end

    def print_dot(graph)
      puts generate_dot(graph)
    end

    def write_dot(graph, filename)
      dot = generate_dot(graph)
      File.write(filename, dot)
    end

  end
end
