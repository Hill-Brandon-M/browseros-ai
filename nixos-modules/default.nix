{ overlays }:

{
  analogue-pocket-sync = import ./epilogue-playback.nix;

  overlayNixpkgsForThisInstance =
    { pkgs, ... }:
    {
      nixpkgs = {
        inherit overlays;
      };
    };
}