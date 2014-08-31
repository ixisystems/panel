Panel
=====

## Getting Started

You'll need Homebrew, Erlang 17.1, and Elixir 1.0.0

```sh-session
brew install libcouchbase
git clone git@github.com:jbsmith/panel.git
MIX_ENV=local mix do deps.get, compile
MIX_ENV=local mix panel.server
```
Now visit: http://localhost:4000/

### Setting up Local Couchbase
### TODO update the following to be more up to date with current assumptions

  - Install Couchbase from couchbase.com
  - create a panel bucket named panel, with a user named panel and password electric
  - load agents by running panel with the local config: 
    - mix do deps.get && MIX_ENV=local iex -S mix
    - in IEX run: Panel.Base.Import.Sampledata.load_sample("data/sampledata.csv")
    - test that sampledata is now readable via a visit to:  http://localhost:4000/sampledata/test

