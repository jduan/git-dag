module GitDag
  class CommitNode < Node
    def initialize(grit_commit)
      @grit_commit = grit_commit
      @parents = []
    end

    def label
      %Q([color="#{color}"])
    end

    def id
      @grit_commit.id
    end

    def add_parent(parent)
      @parents << parent
    end

    def dot_node
      %Q("#{short_sha1}")
    end

    private
    def color
      "black"
    end

    def short_sha1
      @grit_commit.id[0,6]
    end
  end
end
