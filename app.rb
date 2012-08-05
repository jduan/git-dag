#!/usr/bin/env ruby

require 'grit'
require 'pry'
require 'set'

class GitGraph
  def initialize(git_repo)
    @repo = Grit::Repo.new(git_repo)
    @branches = @repo.branches
    @remotes = @repo.remotes
  end

  def output_dot
    all_commits = build_entire_graph
    dot_str = get_dot_str(all_commits)
    puts dot_str
  end

  def get_dot_str(all_commits)
    #puts "all_commits: #{all_commits.size}"
    dot_str = "digraph G {\n"
    all_commits.each do |id, my_commit|
      #puts "commit: #{my_commit.id}"
      #puts "parent size: #{my_commit.parents.size}"
      my_commit.parents.each do |parent|
        dot_str << "#{my_commit.dot_node} -> #{parent.dot_node};\n"
        dot_str << %Q(#{my_commit.dot_node} [label="#{my_commit.short_sha1}"];\n)
        dot_str << %Q(#{parent.dot_node} [label="#{parent.short_sha1}"];\n)
      end
    end
    dot_str << "}\n"
  end

  def build_entire_graph
    all_commits = {}
    @remotes.each do |branch|
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
    end
    #binding.pry
    all_commits
  end

  def find_commits_per_branch(branch)
    @repo.commits(branch, false) # false indicates all commits
  end
end

class MyCommit
  attr_accessor :parents

  def initialize(grit_commit)
    @grit_commit = grit_commit
    @parents = []
  end

  def id
    @grit_commit.id
  end

  def short_sha1
    @grit_commit.id[0,5]
  end

  def dot_node
    "prefix" + @grit_commit.id
  end

  def add_parent(parent)
    #puts "commit #{id} add parent #{parent.id}"
    @parents << parent
    #puts "parents: #{@parents}" if id =~ /07da/
  end
end
gg = GitGraph.new("~/workspace/cube-core")
gg.output_dot
