{
  description = "Base Flake";

  inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
		home-manager.url = "github:nix-community/home-manager/release-26.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		# Secret store for agents (github.com/JanLunge/secretd, private; local checkout).
		secretd.url = "git+file:///home/jan/Code/secretd?ref=main";
		secretd.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, secretd}:
		let
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			nixosConfigurations = {
				nixos = lib.nixosSystem {
					inherit system;
					modules = [ secretd.nixosModules.default ./configuration.nix ];
				};
			};
			homeConfigurations = {
				jan = home-manager.lib.homeManagerConfiguration {
								inherit pkgs;
								modules = [ ./home.nix ];
				};
			};
		};
}
