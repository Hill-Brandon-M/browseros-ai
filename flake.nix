{
  description = "A custom package flake for BrowserOS AI-powered browser.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nix }: let 
    
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];

    forEachSystem = nixpkgs.lib.genAttrs systems;

    overlayList = [ self.overlays.default ];

    pkgsBySystem = forEachSystem ( system:
      import nixpkgs {
        inherit system;
        overlays = overlayList;
      }
    );

    pname = "browseros-ai";

  in rec {

    overlays.default = final: prev: {
      ${pname} = final.callPackage ./package.nix {};
    };

    packages = forEachSystem ( system: {
      ${pname} = pkgsBySystem.${system}.${pname};
      default = pkgsBySystem.${system}.${pname};
    });

  };
}
