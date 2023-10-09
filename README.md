# hoov's dotfiles

A bundle of dotfiles and scripts to help set up an EC2 instance running Amazon Linux from scratch.

> **Note**
> Before proceeding, if you want to run the scripts and use the dotfiles in this repo, make sure you know what are you doing! Settings applied here are highly opinionated and definitely don't suite everyone's needs. We suggest you to create your own set of dotfiles based on this repo.

## Installation Steps

Run:

```sh
# 1. Install system updates in the EC2 machine
sudo yum update -y

# 2. Install git
sudo yum install git -y

# 3. Run the set up script
bash <(curl -s https://raw.githubusercontent.com/hoovbr/dotfiles/main/set_up.sh)

# 4. Restart the shell session
source ~/.zshrc
```

All the scripts in this repo are idempotent, which means you can run them multiple times and they will always produce the same results. Thus, if for some reason you need to run the commands above again (e.g. because they errored out), you can just run them again.

## Which shell settings and tools are we using?

Here is some information about how we set up our shell and why we do so:

- We use [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh), because of its amazing plugins.
- We use [rbenv](https://github.com/rbenv/rbenv) instead of [rvm](https://rvm.io/), because it's easier to manage and more lightweight.
- We use [powerline-shell](https://github.com/milkbikis/powerline-shell) to get those cool path bars (called segments). Particularly useful when SSH'ing into a remote machine and switching between different users.
- We use [Meslo Powerline Font](https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf) as you need a font that supports the directory characters for `powerline-shell`.
- We use [z](https://github.com/rupa/z), an amazing tool to quickly jump between projects. It's like [Alfred](https://www.alfredapp.com/) but for your shell, reduced to folder search only.
- For other configurations check out [set_up_shell.sh](/set_up_shell.sh)

## Credits

Our dotfiles were based off of the following repos:

- What dotfiles is Felix using - https://github.com/KrauseFx/dotfiles - via [@KrauseFx](https://twitter.com/krausefx)
- What Terminal is Felix using - https://github.com/KrauseFx/what-terminal-is-felix-using - via [@KrauseFx](https://twitter.com/krausefx)
- Mathias’s dotfiles - https://github.com/mathiasbynens/dotfiles - via [@mathias](https://twitter.com/mathias)
- Roger's dotfiles - https://github.com/rogerluan/dotfiles - via [@rogerluan](https://twitter.com/rogerluan_)
