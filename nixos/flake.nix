{
  description = "Base Flake";

  inputs = {
		nixpkgs.url = "github:NixOs/nixpkgs/nixos-23.11";	
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {self, nixpkgs, home-manager, nixpkgs-unstable}:
		let
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			nixosConfigurations = {
				nixos = lib.nixosSystem {
					inherit system;
					modules = [ ./configuration.nix
					
					  	# Use unstable package
          				({ config, pkgs, ... }: {
            			environment.systemPackages = with pkgs; [
             
              # Package from nixpkgs-unstable
              (import nixpkgs-unstable { inherit system; }).pinokio
            ];
          })
		   ];
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
