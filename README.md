# pinputs
Pin your NixOS flake inputs to the system flake registry!

# Example
```nix
{
  description = "My NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pinputs.url = "github:pyrotelekinetic/pinputs/main";
  };

  outputs = inputs@{ self, nixpkgs, pinputs }: {
    nixosConfigurations.myComputer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        pinputs.nixosModules.default
        { pins = { inherit inputs; }; }
      ];
    };
  };
}
```



---

    Copyright (C) 2023  Carter "pyrotelekinetic" Ison <carter@isons.org>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
