module GitDag
  class TagNode < Node
    def initialize(id, dot_node, label, parents)
      @id = id
      @dot_node = dot_node
      @label = label
      @parents = parents
    end
  end
end
