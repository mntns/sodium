![sodium logo](https://raw.githubusercontent.com/EddyShure/sodium/develop/logo.png)

>  A fast library for graph/network manipulation inspired by [networkx](https://github.com/networkx/networkx).

[![Build Status](https://travis-ci.org/EddyShure/sodium.svg?branch=master)](https://travis-ci.org/EddyShure/sodium)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  sodium:
    github: EddyShure/sodium
```

## Usage

```crystal
require "sodium"
```

You can create a graph with nodes of any type. For example, if you want to create a
graph with nodes of the type `Int32`:

```crystal
graph = Sodium::Graph(Int32).new()
```

Manipulating the graph is straightforward:

```crystal
# Add individual nodes
graph.add_node(1)
graph.add_node(2)
graph.add_node(3, {weight: 232})

# Add multiple nodes
graph.add_nodes_from([31, 32, 33])

# Add an edge
graph.add_edge(1, 2)
graph.add_edge(66, 88)

# Add multiple edge
graph.add_edges_from([{2, 3}, {4, 5}, {6, 7}])

# Remove a node
graph.remove_node(1)
```

For more information, please check out the [documentation](https://monoton.space/sodium).

## Roadmap

### Graph types
- [x] `Graph`
- [x] `DiGraph`

### Graph Algorithms
- [ ] `DFS`
- [ ] `BFS`
- [ ] `Djikstra`

## Contributing

1. [Fork it](https://github.com/EddyShure/sodium/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [EddyShure](https://github.com/EddyShure) Eddy Shure - creator, maintainer
