{
  appimageTools,
  fetchurl,
  lib,
  ...
}:

let
  pname = "browseros";
  version = "0.52.1";

  src = fetchurl {
    url = "https://cdn.browseros.com/releases/browserclaw/${version}/linux/BrowserOS_neo_v${version}_x64.AppImage";
    hash = "sha256-z63diyNQZSsjgn2xBF+SRYjPiD5dhhFObI7e0yuLEhE=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };

  bname = "browserclaw";

in appimageTools.wrapType2 rec {
  
  inherit pname version src;
  pkgs = pkgs;

  extraInstallCommands = ''
    
    install -m 444 -D ${appimageContents}/"${bname}.desktop" -t $out/share/applications
    
    substituteInPlace $out/share/applications/${bname}.desktop \
      --replace 'Exec=AppRun' 'Exec="${bname}"'
    
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = {
    description = "🌐 The open-source Agentic browser; privacy-first alternative to ChatGPT Atlas, Perplexity Comet, Dia. ";
    homepage = "https://browseros.com/";
    downloadPage = "https://github.com/browseros-ai/BrowserOS/releases";
    license = lib.licenses.agpl3Only;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    # maintainers = with lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}