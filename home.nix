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
  programs.ghostty = {
  	enable = true;
	clearDefaultKeybinds = true;
	installBatSyntax = true;
	installVimSyntax = true;
	systemd.enable = true;
	settings = {
		font-family = "DejaVu Sans Mono";
		theme = "Ayu";
		keybind = [
			# Copy/Paste
			"ctrl+shift+c=copy_to_clipboard"
			"ctrl+shift+v=paste_from_clipboard"
			
			# Font size control
			"ctrl+equal=increase_font_size:1"
			"ctrl+minus=decrease_font_size:1"
			"ctrl+zero=reset_font_size"

			# Closes current surface (tab/window/split)
			"ctrl+a>c=close_surface" 

			# tabs
			"alt+n=new_tab"			# New tab
			"alt+c=close_tab"		# Close tab
			"alt+r=prompt_tab_title"	# Prompt for tab title 
			"alt+ctrl+l=next_tab"		# Go to right tab 
			"alt+ctrl+h=previous_tab" 	# Go to left tab
			"alt+comma=move_tab:-1" 	# Move tab left
			"alt+period=move_tab:1" 	# Move tab right

			# quick tab switch
			"alt+1=goto_tab:1"
			"alt+2=goto_tab:2"
			"alt+3=goto_tab:3"
			"alt+4=goto_tab:4"
			"alt+5=goto_tab:5"
			"alt+6=goto_tab:6"
			"alt+7=goto_tab:7"
			"alt+8=goto_tab:8"
			"alt+9=goto_tab:9"

			# pane switch
			"alt+h=goto_split:right"
			"alt+j=goto_split:down"
			"alt+k=goto_split:up"
			"alt+l=goto_split:left"

			# split
			"ctrl+a>shift+\\=new_split:right"	# Split Horizontally
			"ctrl+a>-=new_split:down"	# Split Vertically

			"ctrl+a>z=toggle_split_zoom"

			"ctrl+a>e=equalize_splits"
		];
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
