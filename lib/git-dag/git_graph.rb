module GitDag
  class GitGraph
    def initialize(git_repo)
      @repo = Grit::Repo.new(git_repo)
      @branches = @repo.branches
      @remotes = @repo.remotes
      @all_branches = @remotes.reject {|r| r.name =~ /HEAD/} + @branches
    end

    def output_dot_file
      all_commits = build_entire_graph
      add_tag_nodes(all_commits)
      get_dot_str(all_commits)
    end

    def get_dot_str(all_commits)
      #puts "all_commits: #{all_commits.size}"
      dot_str = "digraph G {\n"
      all_commits.each do |id, node|
        node.parents.each do |parent|
          dot_str << "#{node.dot_node} -> #{parent.dot_node};\n"
        end
        dot_str << %Q(#{node.dot_node} #{node.label};\n)
      end
      dot_str << Legend.dot_output

      dot_str << "}\n"
    end

    def build_entire_graph
      all_commits = {}
      @all_branches.each do |branch|
        commits = find_commits_per_branch(branch.name)
        commits.each do |commit|
          my_commit = CommitNode.new(commit)
          all_commits[commit.id] = my_commit unless all_commits.has_key? commit.id
          #puts "adding #{commit.id} to hash"
          commit.parents.each do |parent|
            parent_commit = CommitNode.new(parent)
            my_commit.add_parent(parent_commit)
            #all_commits[parent.id] = parent_commit unless all_commits.has_key? parent.id
          end
        end

        parent_of_fake_head = all_commits[commits[0].id]
        fake_head = create_fake_commit_for_head(branch.name, parent_of_fake_head)
        all_commits[fake_head.id] = fake_head
      end
      all_commits
    end

    def add_tag_nodes(all_commits)
      @repo.tags.each do |tag|
        commit = tag.commit
        parent_commit = all_commits.find {|id, c| id == commit.id}[1]
        id = tag.name
        dot_node = %Q("#{tag.name}")
        label = %Q([color="green" shape=circle])
        tag_node = TagNode.new(id, dot_node, label, [parent_commit])
        all_commits[tag_node.id] = tag_node
      end
    end

    def create_fake_commit_for_head(branch_name, parent)
      id = branch_name
      dot_node = %Q("#{branch_name}")
      label = %Q([color="blue" shape=box])
      FakeHead.new(id, dot_node, label, [parent])
    end

    def find_commits_per_branch(branch)
      @repo.commits(branch, false) # false indicates all commits
    end
  end
end
