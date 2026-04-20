{ config, pkgs, nixvim, ... }:

{
  home.username = "pujan";
  home.homeDirectory = "/home/pujan";
  home.stateVersion = "25.11"; 

  # Home Manager managing itself.
  programs.home-manager.enable = true;

  # Standard packages which don't require dotfiles configuration.
  home.packages = with pkgs; [
  	ripgrep # Used by Telescope.nvim
	fd 	# Used by Telescope.nvim

	firefox  # Browser
	hyprland # Wayland compositor
  ];

  # Git Configuration: ~/.gitconfig
  programs.git = {
  	enable = true;
	settings = {
		user = {
			name = "Pujan Khunt";
			email = "pujankhunt2412@gmail.com";
		};
		init.defaultBranch = "main";
	};
  };

  # Alacritty: ~/.config/alacritty/alacritty.toml
  programs.alacritty = {
	  enable = true;

	  settings = {
	    window = {
	      opacity = 0.75;
	    };

	    font = {
	      size = 15.0;

	      normal = {
		family = "JetBrainsMono Nerd Font";
		style = "Regular";
	      };

	      bold = {
		family = "JetBrainsMono Nerd Font";
		style = "Bold";
	      };

	      italic = {
		family = "JetBrainsMono Nerd Font";
		style = "Italic";
	      };
	    };

	    colors = {
	      primary = {
		background = "0x1e1e2e";
		foreground = "0xcdd6f4";
	      };
	    };
	  };
  	};

  imports = [
  	nixvim.homeModules.nixvim
  ];

  # Neovim Configuration: ~/.config/nvim
  programs.nixvim = {
	enable = true;
	defaultEditor = true; # updates the EDITOR environment variable

	globals.mapleader = " ";
	globals.maplocalleader = " ";

	opts = {
		number = true;
		relativenumber = true;
	};

	plugins.telescope = {
		enable = true;

		keymaps = {
			"<leader>fd" = "find_files";
			"<leader>lg" = "live_grep";
			"<leader>fh" = "help_tags";
			"<leader>fr" = "resume";
		};

		settings = {
			pickers = {
				find_files.theme = "dropdown";
				live_grep.theme = "ivy";
				help_tags.theme = "ivy";
			};
			defaults = {

			# DO NOT TOUCH
			results_title = "You can't spell advertisements without semen between the tits.";
			# DO NOT TOUCH


			file_ignore_patterns = [
				"%.env"
				"^node_modules/"
				".git/"
				"%.class"
			];
			mappings = {
			    i = {
			      "<C-j>" = "move_selection_next";
			      "<C-k>" = "move_selection_previous";
			      "<C-l>" = "select_default";
			      "<C-v>" = "file_vsplit";
			      "<C-h>" = "file_split";
			      "<C-o>" = "close";
			    };
			    n = {
			      "v" = "file_vsplit";
			      "h" = "file_split";
			    };
			  };
			};
	      };
	};
  };
}
