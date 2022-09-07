{ ... } @attrs:
let lib = import ./lib.nix attrs; in
lib.makeConfig {
  hw = ./dev-sm/hardware-configuration.nix;
  role = ./roles/dev.nix;

  # config just overrides / extends params set in the role
  config = {
    services.xserver.dpi = 210;

    networking.hostName = "devhost";
    networking.wireless.enable = true;
  };
}


