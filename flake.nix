{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";

    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    theme-bobthefish = {
      url = "github:oh-my-fish/theme-bobthefish";
      flake = false;
    };

    fish-foreign-env = {
      url = "github:oh-my-fish/plugin-foreign-env";
      flake = false;
    };

    # oh-my-fish = {
      # url = "github:oh-my-fish/oh-my-fish";
      # flake = false;
    # };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";

      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, theme-bobthefish, fish-foreign-env, nixos-hardware, home-manager }:

    let overlays = [
      (final: prev: {
        fishPlugins.theme-bobthefish = theme-bobthefish;
        fishPlugins.foreign-env = fish-foreign-env;
      })
    ]; in {

    nixosConfigurations.intel-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./system/intel-vm.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.fedir = import ./users/fedir/home.nix;
          }
        ];
    };

    nixosConfigurations.thinkpad-e14 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./system/thinkpad-e14.nix

          nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.fedir = import ./users/fedir/home.nix;
          }
        ];
    };
  };
}
