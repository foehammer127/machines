{ config, lib, pkgs, ... }: {
  imports = [
    ./tailscale
    ./vaultwarden
  ];
}
