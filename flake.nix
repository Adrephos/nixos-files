{
  description = "NixOS config flake";

  outputs =
    inputs@{ self
    , nixpkgs
    , home-manager
    , ...
    }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
    in
    {
      inherit lib;
      nixosConfigurations = {
        vin = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/vin ];
        };
      };

      homeConfigurations = {
        "gleipnir@vin" = lib.homeManagerConfiguration {
          modules = [ ./home/gleipnir/vin.nix ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
