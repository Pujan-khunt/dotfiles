{
	description = "System Configuration Hub";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		
		nixvim = {
			url = "github:nix-community/nixvim";
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, nixvim, home-manager, ... }: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hardware-configuration.nix
				./configuration.nix
				
				# NixVim module
				nixvim.nixosModules.nixvim

				# Home Manager module
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = { inherit nixvim; };
					home-manager.users.pujan = import ./home.nix;
				}
			];
		};

		# Standalone Home Manager Configuration (updated using `home-manager switch`)
		homeConfigurations."nixos" = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages."x86_64-linux";

			extraSpecialArgs = { inherit nixvim; };
			
			modules = [
				./home.nix
			];
		};
	};
}
