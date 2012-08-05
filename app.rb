#!/usr/bin/env ruby

require 'grit'
require 'pry'
require 'set'

class GitGraph
  def initialize(git_repo)
    @repo = Grit::Repo.new(git_repo)
    @branches = @repo.branches
    @remotes = @repo.remotes
    @all_branches = @remotes.reject {|r| r.name =~ /HEAD/} + @branches
  end

  def output_dot
    all_commits = build_entire_graph
    dot_str = get_dot_str(all_commits)
    puts dot_str
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
    dot_str << "}\n"
  end

  def build_entire_graph
    all_commits = {}
    @all_branches.each do |branch|
      commits = find_commits_per_branch(branch.name)
      commits.each do |commit|
        my_commit = MyCommit.new(commit)
        all_commits[commit.id] = my_commit unless all_commits.has_key? commit.id
        #puts "adding #{commit.id} to hash"
        commit.parents.each do |parent|
          parent_commit = MyCommit.new(parent)
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

class Node
  attr_accessor :parents, :label, :id, :dot_node
end

class MyCommit < Node
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

class FakeHead < Node
  def initialize(id, dot_node, label, parents)
    @id = id
    @dot_node = dot_node
    @label = label
    @parents = parents
  end
end

gg = GitGraph.new("~/workspace/cube-core")
gg.output_dot
