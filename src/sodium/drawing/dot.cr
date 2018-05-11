require "../graph"

module Sodium
  module Drawing
    module Dot
      private def gen_attributes(attr)
        if !attr.empty?
          attr.map {|k,v| "#{k}=\"#{v}\""}.join(",")
        end
      end

      # Generates string in dot format
      def generate_dot(graph)
        edges = graph.edges()
        dot = ""

        dot += "graph {\n"
        graph.nodes_with_data.each do |k, v|
          dot += "  #{k}[#{gen_attributes(v)}]\n"
        end

        edges.each do |edge|
          dot += "  #{edge[0]} -- #{edge[1]}\n"
        end

        dot += "}\n"
      end

      # Writes dot file to path
      def write_dot(graph, path)
        dot = generate_dot(graph)
        File.write(path, dot)
      end

    end
  end
end
