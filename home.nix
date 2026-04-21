{ config, pkgs, nixvim, ... }:

{
  home.username = "pujan";
  home.homeDirectory = "/home/pujan";
  home.stateVersion = "25.11"; 

  # Home Manager managing itself.
  programs.home-manager.enable = true;

  # Standard packages which don't have defined modules.
  home.packages = with pkgs; [
  	brightnessctl # Brightness Manger CLI
  ];

  programs.bash.enable = true;

  # Browser
  programs.firefox.enable = true;

  # Used by Telescope.nvim
  programs.fd.enable = true;
  programs.ripgrep.enable = true;

  # Bluetooth Manager TUI
  programs.bluetuith.enable = true;

  # Version Control System
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

  # Terminal Emulator
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

  # Neovim Distribution
  programs.nixvim = {
	enable = true;
	defaultEditor = true; # updates the EDITOR environment variable

	globals.mapleader = " ";
	globals.maplocalleader = " ";

	opts = {
		number = true;
		relativenumber = true;
	};

	keymaps = [
		{
			mode = "n";
			key = "<leader>e";
			action = "<cmd>Oil<cr>";
			options.desc = "Open Oil file explorer";
		}
		{
			mode = [ "n" "t" "v" ];
			key = "<C-j>";
			action = "<C-d>zz";
			options.desc = "Scroll down (centered)";
		}
		{
			mode = [ "n" "t" "v" ];
			key = "<C-k>";
			action = "<C-u>zz";
			options.desc = "Scroll up (centered)";
		}
		{
			mode = "v";
			key = "<S-k>";
			action = ":m '<-2<cr>gv=gv";
			options.desc = "Move selection up";
		}
		{
			mode = "v";
			key = "<S-j>";
			action = ":m '>+1<cr>gv=gv";
			options.desc = "Move selection down";
		}
		{
			mode = "n";
			key = "<S-u>";
			action = "<C-r>";
			options.desc = "Redo action";
		}
		{
			mode = "n";
			key = "m";
			action = "s";
			options.desc = "Delete and go to insert mode";
		}
		{
			mode = "n";
			key = "'";
			action = "/";
			options.desc = "Forward search in buffer";
		}
		{
			mode = "n";
			key = "<Esc>";
			action = "<cmd>nohl<cr>";
			options.desc = "Remove current highlights";
		}
		{
			mode = [ "n" "v" ];
			key = "[t";
			action = "<cmd>tabprev<cr>";
			options.desc = "Goto previous tab";
		}
		{
			mode = [ "n" "v" ];
			key = "]t";
			action = "<cmd>tabnext<cr>";
			options.desc = "Goto next tab";
		}
		{
			mode = "n";
			key = "<leader>q";
			action = "<cmd>q<cr>";
			options.desc = "Close current window";
		}
	];

	# https://github.com/nvim-tree/nvim-web-devicons
	plugins.web-devicons.enable = true;

	# https://github.com/stevearc/oil.nvim
	# :h oil.nvim
	plugins.oil= {
		enable = true;
		settings = {
		  default_file_explorer = true;
		  columns = [
		    "icon"
		    "lsp"
		  ];
		  keymaps = {
		  	"l" = "actions.select";
			"h" = "actions.parent";
		  };
		  skip_confirm_for_simple_edits = true;
		  delete_to_trash = true;
		  watch_for_changes = true;
		};
	};

	# https://github.com/nvim-telescope/telescope
	# :h telescope.nvim
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
