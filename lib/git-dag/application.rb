#!/usr/bin/env ruby

require 'grit'

module GitDag
  module Application
    def self.run(git_repo_path)
      git_graph = GitGraph.new(git_repo_path)
      puts git_graph.output_dot_file
    end
  end
end
