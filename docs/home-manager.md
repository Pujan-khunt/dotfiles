## Home Manager

Nix's `configuration.nix` is meant to only manage system level configurations like the bootloader, kernel modules, system-wide daemons etc.

To manager your user level applications, I use Home Manager which brings the same philosophy of Nix. It provides a big number of user applications which can be configured via modules provided by Home Manager.

E.g.
```nix
programs.git = {
    enable = true;
    ignores = [ "*~" "*.swp" ];
    settings = {
        core.editor = "nvim";
    };
}
```

Home Manager will automatically create the `.gitconfig`, hash its contents and save it inside `/nix/store`. It will then create a symlink that goes into wherever the configuration file is expected. In this case it will link it to `~/.config`.

This allows to rebuild user applications without rebuilding entire system configuration using:

```sh
home-manager switch
```
