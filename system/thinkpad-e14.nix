{ pkgs, ... }:
{

  imports = [
    ./thinkpad-e14-hardware.nix
    ./templates/dev-gfx.nix
  ];

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=0
  '';

  networking.hostName = "nixos-thinkpad"; # Define your hostname.

  services.xserver.dpi = 125;

  services.postgresql = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    libreoffice
  ];

  # Enable backlit control
  services.illum.enable = true;

  services.autorandr = {
    enable = true;
    profiles = {
      "ext-dell" = {
        fingerprint = {
          "HDMI-A-0" = "00ffffffffffff0010ac67d04c45473032180103803c2278ee4455a9554d9d260f5054a54b00b300d100714fa9408180778001010101565e00a0a0a029503020350055502100001a000000ff0047483835443443413047454c0a000000fc0044454c4c205532373135480a20000000fd0038561e711e000a20202020202001b5020322f14f1005040302071601141f1213202122230907078301000065030c001000023a801871382d40582c250055502100001e011d8018711c1620582c250055502100009e011d007251d01e206e28550055502100001e8c0ad08a20e02d10103e9600555021000018483f00ca808030401a50130055502100001e00000094";
          "eDP" = "00ffffffffffff0006af3d4000000000211c0104a51f1178039b85925659902920505400000001010101010101010101010101010101143780b87038244010103e0035ae10000018000000000000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343048414e30342e30200a0097";
        };

        config = {
          eDP.enable = false;
          "HDMI-A-0" = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "2560x1440";
          };
        };
      };
      "int-only" = {
        fingerprint = {
          "eDP" = "00ffffffffffff0006af3d4000000000211c0104a51f1178039b85925659902920505400000001010101010101010101010101010101143780b87038244010103e0035ae10000018000000000000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343048414e30342e30200a0097";
        };
        config = {
          eDP = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
          };
        };
      };

    };

    hooks = {
      postswitch = {
        "change-dpi" = ''
            case "$AUTORANDR_CURRENT_PROFILE" in
                  default)
                    DPI=125
                    ;;
                  int-only)
                    DPI=125
                    ;;
                  ext-dell)
                    DPI=110
                    ;;
                  *)
                    echo "Unknown profle: $AUTORANDR_CURRENT_PROFILE"
                    exit 1
                esac
                echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
          '';
      };
    };
  };

  # Make autorandr automatically chose profile when monitor change
  services.udev.extraRules = ''
      ACTION=="change", \
      SUBSYSTEM=="drm", \
      RUN+="${pkgs.autorandr}/bin/autorandr -c"
  '';

  # Set location provider for redshift
  location.provider = "manual";
  location.latitude = 50.45466;
  location.longitude = 30.5238;

  services.redshift.enable = true;
  services.redshift.temperature.day = 5500;
  services.redshift.temperature.night = 5500;


  # this will enable libinput instead of synaptics
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;
  services.xserver.libinput.touchpad.middleEmulation = true;
  services.xserver.libinput.touchpad.tapping = true;

  # Enables wireless support via wpa_supplicant.
  networking.wireless.enable = true;
  networking.firewall.enable = true;

  # Allow installing "unfree" packages like vs code
  nixpkgs.config.allowUnfree = true;
}

