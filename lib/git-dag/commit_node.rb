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
      #puts "commit #{id} add parent #{parent.id}"
      @parents << parent
      #puts "parents: #{@parents}" if id =~ /07da/
    end

    def dot_node
      %Q("#{short_sha1}")
    end

    private
    def color
      if merge?
        "red"
      else
        "black"
      end
    end

    def short_sha1
      @grit_commit.id[0,6]
    end

    def merge?
      @parents.size > 1
    end
  end
end
