{
  appimageTools,
  fetchurl,
  lib,
  ...
}:

let
  pname = "BrowserOS";
  version = "0.28.0";

  src = fetchurl {
    url = "https://github.com/browseros-ai/BrowserOS/releases/download/v${version}/BrowserOS_v${version}_x64.AppImage";
    hash = "sha256-YY3g0xNr/Jm4Q1PJSg27vO+M5jur/lM2a6iTN03BbCA=";
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
    description = "🌐 The open-source Agentic browser; privacy-first alternative to ChatGPT Atlas, Perplexity Comet, Dia. ";
    homepage = "https://browseros.com/";
    downloadPage = "https://github.com/browseros-ai/BrowserOS/releases";
    license = lib.licenses.agpl3Only;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    # maintainers = with lib.maintainers; [ onny ];
    platforms = [ "x86_64-linux" ];
  };
}