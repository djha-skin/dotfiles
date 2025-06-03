{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { home-manager, nixpkgs, nixpkgs-unstable, ... }@inputs:
        let
        username = "skin";
    system = "x86_64-linux";
    timezone = "America/Denver";
    locale = "en_US.UTF-8";
    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
    };
    unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
    };
    hostname = "nixos";
    in
    {
        nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs username system; };
            modules = [ ./configuration.nix ];
        };
        homeConfigurations."dhaskin" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
                config = { allowUnfree = true; };
                system = "x86_64-linux";
            };
            extraSpecialArgs = {
                inherit inputs username;
                unstable = unstable;
            };
            modules = [ ./home.nix
                        ./machine-specific-not-nixos.nix];
        };
        homeConfigurations."skin" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
                config = { allowUnfree = true; };
                system = "x86_64-linux";
            };
            extraSpecialArgs = { inherit inputs username unstable; };
            modules = [ ./home.nix
                        ./machine-specific-nixos.nix
                        ];
        };
    };
}