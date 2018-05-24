# require "../../graph"

# module Sodium
#   module Algorithms
#     module Traversal
#       module DFS(T)

#         # Returns edges produced in depth-first search
#         def dfs_edges(source)
#           visited = Set(T).new
#           stack = Array(Tuple(T, T)).new

#           visited << source
          
#           self.neighbours(node).each do |n|
#             stack << {source, n.to_i}
#           end


#           while !stack.empty?
#             node = stack.pop
#             parent = node[0]

#             if !visited.includes?(node)
#               visited << node
#               self.neighbours(node).each do |neighbour|
#                 ni = neighbour.as(T)
#                 edges << {node, ni}
#                 stack << neighbour.as(T)
#               end
#             end
#           end

#         while stack:
#             parent,children = stack[-1]
#             try:
#                 child = next(children)
#                 if child not in visited:
#                     yield parent,child
#                     visited.add(child)
#                     stack.append((child,iter(G[child])))
#             except StopIteration:
#                 stack.pop()


#           edges
#         end

#         # Returns tree produced by dept-first search
#         def dfs_tree(source)
#           digraph = DiGraph(T).new
#           digraph.add_nodes_from(dfs_edges(self, source))
#         end

#       end
#     end
#   end
# end
