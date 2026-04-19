{
	description = "System Configuration Hub";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		
		nixvim = {
			url = "github:nix-community/nixvim";
		};
	};

	outputs = { self, nixpkgs, nixvim, ... }: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hardware-configuration.nix
				./configuration.nix
				
				# NixVim module
				nixvim.nixosModules.nixvim
			];
		};
	};
}
