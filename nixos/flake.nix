{
  description = "Default flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-index-database, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      dregsdesk15 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          nix-index-database.nixosModules.nix-index
        ];
      };
    };
  };
}
