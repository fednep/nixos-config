{
  description = "A very basic flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";

    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    oh-my-fish = {
      url = "github:oh-my-fish/oh-my-fish";
      flake = false;
    };

    theme-bobthefish = {
      url = "github:oh-my-fish/theme-bobthefish";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";

      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, oh-my-fish, theme-bobthefish, home-manager }:
    let overlays = [
      (final: prev: {
        fishPlugins.omf = oh-my-fish;
        fishPlugins.theme-bobthefish = theme-bobthefish;
      })
    ]; in {
    nixosConfigurations.mac-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./system/intel-vm.nix
        ];
    };
  };
}
