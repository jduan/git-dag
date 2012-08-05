# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "git-dag/version"

Gem::Specification.new do |s|
  s.name        = "git-dag"
  s.version     = GitDag::VERSION
  s.authors     = ["Jingjing Duan"]
  s.email       = ["jingjing.duan@gmail.com"]
  s.homepage    = "https://github.com/jduan/git-dag"
  s.summary     = %q{A ruby script that generates a 'dot' file (Git DAG tree) for a given Git repository.}
  s.description = %q{A ruby script that generates a 'dot' file (Git DAG tree) for a given Git repository.}

  s.required_rubygems_version = ">= 1.8.10"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("grit", "~> 2.5.0")
end
