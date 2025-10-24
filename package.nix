{
  appimageTools,
  fetchurl,
  lib,
  ...
}:

let
  pname = "Playback";
  version = "1.8.0";

  src = fetchurl {
    url = "https://epilogue.nyc3.cdn.digitaloceanspaces.com/releases/software/Playback/version/${version}/release/linux/Playback.AppImage";
    hash = "sha256-hnRUoKrYrtwXe+qBeEYhpzwtV0M/p6pM7OL1dwt4YDs=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };

in appimageTools.wrapType2 rec {
  
  inherit pname version src;
  pkgs = pkgs;

  extraInstallCommands = ''
    
    install -m 444 -D ${appimageContents}/"${pname}.desktop" -t $out/share/applications
    
    # substituteInPlace $out/share/applications/${pname}.desktop \
    #   --replace 'Exec=AppRun' 'Exec="${pname}"'
    
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = {
    description = "Playback is the application which allows you to play and manage your cartridges with the GB Operator. It's the heart of the experience, allowing you to replay your childhood games.";
    homepage = "https://www.epilogue.co/";
    downloadPage = "https://www.epilogue.co/downloads";
    # license = lib.licenses.none;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    # maintainers = with lib.maintainers; [ onny ];
    platforms = [ "x86_64-linux" ];
  };
}