# dotfiles

Simple repo to contain some configurations and similar

based on [this thread]( https://news.ycombinator.com/item?id=11071754 ) with a writeup [here]( https://www.atlassian.com/git/tutorials/dotfiles ).

## Commands

### On creation

```git
git init --bare $HOME/.myconf
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```

### On replication

Start with

```bash
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'

and

echo ".myconf" >> .gitignore
```

```git
git clone --bare <git-repo-url> $HOME/.myconf
```
