# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ 
  	# Include the results of the hardware scan.
	./hardware-configuration.nix
  ];

  boot = {
	  # Use `systemd-boot` bootloader without displaying it until on keypress.
	  loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
		timeout = 0;
	  };
	  # Disable output from kernel logs.
	  consoleLogLevel = 0;
	  initrd.verbose = false;
	  kernelParams = [
	  	"quiet"
		"splash"
		"boot.shell_on_fail"
		"loglevel=3"
		"rd.systemd.show_status=false"
		"rd.udev.log_level=3"
		"udev.log_priority=3"
	  ];
	  # Enable `plymouth` to show animations on boot.
	  plymouth = {
	  	enable = true;
		theme = "circle_hud";
		themePackages = with pkgs; [
			(adi1090x-plymouth-themes.override {
				selected_themes = [ "circle_hud" ];
			})
		];
	  };
  };

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs;
  [ git vim ];

  programs.hyprland.enable = true;

  # Enables media player control via playerctl CLI.
  services.playerctld.enable = true;

  time.timeZone = "Asia/Kolkata";

  services.pipewire = {
    enable = true;
    wireplumber.enable = true; # Installs wpctl to manage volume.
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.pujan = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   };

  hardware.bluetooth = {
  	enable = true;
	powerOnBoot = true;
	settings.General.Experimental = true;
  };

  fonts.packages = with pkgs; [
  	nerd-fonts.jetbrains-mono
  ];

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.firewall.enable = false;

  services.keyd = {
	enable = true;
	keyboards = {
		default = {
			ids = [ "*" ]; # Applies to all keyboards
			settings = {
				main = {
					# CapsLock = Esc (on press) + Ctrl (on hold)
					capslock = "overload(control, esc)";
					esc = "capslock";
				};
			};
		};
	};
  };
  system.stateVersion = "25.11";
}

