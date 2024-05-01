{ config, lib, pkgs, nixpkgs, hostname, ... }: {
  imports = [
    ../../hardware/digitalocean.nix
  ];

  time.timeZone = "America/New_York";

  foehammer = {
    vaultwarden.enable = true;
    restic = {
      enable = true;
    };
  };

  swapDevices = [{
    device = "/var/lib/swap";
    size = 1024 * 1; # 1 GB Swap.
  }];

  system.stateVersion = "24.05";
}

