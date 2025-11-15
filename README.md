# Elvish script to initialize ssh-agent
The command `ssh-agent` uses sh-like sintax to initialize the agent, therefore usual `eval "$(ssh-agent -s)"` does not work on Elvish shell.
This become troublesome when using ssh git repositories and the usual behavior is not to initialize the ssh-agent every time to open a new terminal.

The `ssh-agent.elv` script parse ssh-agent to set up the adequate environment using Elvish sintax.

## How to use
1. Add `ssh-agent.elv` into one of Elvish [module search directories](https://elv.sh/ref/command.html#module-search-directories) such as `~/.config/elvish/lib`.
2. Use the script on `rc.elv` and `ssh-add` to every terminal setup it initializes the agent and set the adequate ssh keys. On `rc.elv` do:
```
# On rc.elv
# Start ssh-agent
use ssh-agent

# Add ssh git key
ssh-add -q ~/.ssh/git_key
```
