{ overlays }:

{
  analogue-pocket-sync = import ./browseros-ai.nix;

  overlayNixpkgsForThisInstance =
    { pkgs, ... }:
    {
      nixpkgs = {
        inherit overlays;
      };
    };
}