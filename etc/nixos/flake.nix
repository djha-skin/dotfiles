{
  description = "NixOS configuration by djha-skin";

  inputs = {
    nixkpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ...}@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86-64_linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
