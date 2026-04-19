## Neovim (NixVim)

Neovim is the primary text editor that I use. I already had a Neovim configuration based on my needs
which I had to abandon, since it didn't support NixOS's declarative ideology.


### What is NixVim?

NixVim is a Neovim distribution (like LunarVim, LazyVim etc), but it is different than all these, since
its meant to solve a different problem than all these popular distributions. NixVim is a configuration framework
for Neovim which is entirely built around Nix modules.


### How is NixVim different than other Neovim distributions?

Instead of writing your own `init.lua` with a package manager like `lazy.nvim` which installs and loads packages
at runtime, you write configuration in `Nix`. NixVim acts as a compiler by reading your configuration, installing
necessary packages from `nixpkgs` repository and generating the `init.lua` and adding it to `/nix/store`.


### Difference in philosophies

In Neovim, you imperatively instruct it to load a plugin using `require("lualine").setup{}`. In NixVim, you declaratively
define the desired state in the Nix configuration `plugins.lualine.enable = true`. The neovim package manager like `lazy.nvim`
will download packages from the internet during runtime, which would lead to a different state in different people's machine
since the state of your OS is being changed at runtime. NixOS would flip it by installing and setting everything up at build time 
and locking the exact dependencies in `flake.lock`, guaranteeing the same state on every system.


### Customizing Neovim

Now instead of writing `lua`, you write `Nix` and spend more time with [`NixVim` documentation](https://nix-community.github.io/nixvim/).
Instead of updating your configuration at runtime using `:Lazy update`, you update it at build time using `nix flake update`.
