{
  description = "NixOS config flake";

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      brave-previews,
      claude-code,
      ...
    }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
    in
    {
      inherit lib;
      nixosConfigurations = {
        vin = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/vin ];
        };

        elend = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/elend ];
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    templ.url = "github:a-h/templ";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    brave-previews.url = "github:kcalvelli/brave-browser-previews";
    brave-previews.inputs.nixpkgs.follows = "nixpkgs";

    boosteroid.url = "github:Adrephos/boosteroid-flake";

    claude-code.url = "github:sadjow/claude-code-nix";

    yazi.url = "github:sxyazi/yazi";

    herdr.url = "github:herdrdev/herdr";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
