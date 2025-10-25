# BrowserOS AI Web Browser Nix Flake Package

This repository contains a Nix package for BrowserOS, an AI-powered open-source browser. The package uses Nix Flake to manage dependencies and simplify the installation process on NixOS.

## Package Description

BrowserOS is a cutting-edge web browser that leverages artificial intelligence to enhance your browsing experience. It offers features such as privacy protection, enhanced search capabilities, and integration with AI tools like ChatGPT. This package provides an easy way to install BrowserOS on systems running NixOS or other distributions supported by Nix.

## Installation

There are several methods for installation:

### Method 1: Direct Invocation
If `nix` is available on your system, you can run BrowserOS using the following command:
```bash
nix run github:Hill-Brandon-M/browseros-ai
```

### Method 2: Installation as NixOS flake input
If you are running NixOS or another distribution supported by Nix with flakes enabled, you can install BrowserOS by adding this repository to your `flake.nix` in the following manner:
```nix
{
    # ...
    
    inputs.browseros-ai = {
        url = "github:Hill-Brandon-M/browseros-ai";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # ...
    
    outputs = { self, nixpkgs, browseros-ai, ... }:
       let
            inputModules = ({config, pkgs, ...}: {
                nixpkgs.overlays = [ 
                    browseros-ai.overlays.default 
                    # ... Other input overlays ...
                ];
            });
          
            # ...

       in {
            # ...

            nixosConfigurations = {
                
                # ...

                pc = nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit inputs nixpkgs;};
                    modules = [
                        inputModules
                        # ... Other configuration files ...
                    ];
                };
            
            };
        }
}

```
