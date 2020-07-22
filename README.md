# mplough.github.io

This is the Jekyll repo for [mplough.github.io](https://mplough.github.io/).

## Local work

To do local work prior to pushes, I use [Homebrew's
Ruby](https://formulae.brew.sh/formula/ruby).  I don't use
[`rbenv`](https://github.com/rbenv/rbenv) at the moment as it takes bloody ages
to build and install Ruby from source via e.g. `rbenv install 2.7.1`.  I don't
do a ton with Ruby right now and I'd rather have a machine ready to work on my
blog in less than an hour.

Run `make setup` to install all required Ruby gems.  This takes way longer than
I would like as well, but it's not really avoidable given my use of Jekyll.

Run `make serve` to run a local version of the blog.
