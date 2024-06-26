{...}: {
  age.identityPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/tailscale"
      "/var/lib/NetworkManager"
      "/var/log"
      "/var/lib/nixos"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];

    users.foehammer = {
      files = [];

      directories = [
        "doc"
        "tmp"
        ".local/share/direnv/allow"
        ".cache/nvim/luac"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    };
  };
}
