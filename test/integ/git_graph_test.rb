require 'test_helper'

EXPECTED_DOT_FILE = <<HERE
digraph G {
"8b61ae" -> "100099";
"8b61ae" -> "37f6a9";
"8b61ae" [color="red"];
"37f6a9" -> "45b109";
"37f6a9" [color="black"];
"100099" -> "45b109";
"100099" [color="black"];
"45b109" -> "bdd658";
"45b109" -> "2253ce";
"45b109" [color="red"];
"bdd658" -> "5defde";
"bdd658" -> "c554da";
"bdd658" [color="red"];
"5defde" -> "7b1e4b";
"5defde" [color="black"];
"2253ce" -> "7b1e4b";
"2253ce" [color="black"];
"c554da" -> "7b5eb3";
"c554da" [color="black"];
"7b1e4b" -> "7b5eb3";
"7b1e4b" [color="black"];
"7b5eb3" [color="black"];
"origin/dev" -> "8b61ae";
"origin/dev" [color="blue" shape=box];
"origin/master" -> "8b61ae";
"origin/master" [color="blue" shape=box];
"dev" -> "37f6a9";
"dev" [color="blue" shape=box];
"master" -> "8b61ae";
"master" [color="blue" shape=box];
"0.0.1" -> "c554da";
"0.0.1" [color="green" shape=circle];
"0.0.2" -> "37f6a9";
"0.0.2" [color="green" shape=circle];
}
HERE

module GitDag
  class GitGraphTest < MiniTest::Unit::TestCase
    def test_output_dot_file
      git_graph = GitGraph.new("./sample_repo")
      dot_file = git_graph.output_dot_file
      assert_equal(EXPECTED_DOT_FILE, dot_file)
    end
  end
end
