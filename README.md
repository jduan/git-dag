## git-dag

git-dag is a ruby script that generates a DAG tree (in the 'dot' format) for a
given Git repository.

## Preprequisite
You need to have Ruby installed. Try [RVM](https://rvm.io) or
[rbenv](http://rbenv.org) if you don't have one installed.

You need to have [Graphviz](http://graphviz.org/) installed if you want
to render the DAG visually. You can install it using the package manager
provided by your OS.

For instance, if you use Mac OS X and have homebrew installed, you can do:

    $ brew install graphviz

## Install
Easy install with RubyGems:

    $ gem install git-dag

## Usage
To generate a DAG (in the format 'dot') for a Git repository, do

    $ git-dag <path_to_git_repo> > history.dot

Use to 'dot' to draw the DAG:

    $ dot -Tsvg history.dot -o history.svg

You can pipe the 2 commands together:

    $ git-dag <path_to_git_repo> | dot -Tsvg -o history.svg

Note that if it take a good amount of time if your repository has a long history
of commits.

Now you can open up 'history.svg' in your browser to see the DAG.

Graphviz supports a lot of other formats, such as jpg, pdf, png, ps2 etc. Please
see [Graphviz](http://graphviz.org/) for more info.
