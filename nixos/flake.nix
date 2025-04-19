{
  description = "Default flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    winepinnednixpkgs.url = "github:NixOS/nixpkgs/0e82ab234249d8eee3e8c91437802b32c74bb3fd";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-flatpak,
      winepinnednixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      winepinnedpkgs = import winepinnednixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        dregsdesk15 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system inputs winepinnedpkgs;
          };
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./configuration.nix
          ];
        };
      };
    };
}
