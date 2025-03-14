{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { home-manager, nixpkgs, ... }@inputs:
        let
        username = "dhaskin";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
    };
    in
    {
        #nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        #    specialArgs = { inherit inputs username system; };
        #    modules = [ ./configuration.nix ];
        #};
        homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs username; };
            modules = [ ./home.nix ];
        };
    };
}