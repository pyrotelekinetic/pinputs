{

description = "Pin your NixOS flake inputs to the system flake registry";

outputs = { self }: {
  nixosModules.default = { config, lib, ... }: with lib; {
    options.pins = {
      inputs = mkOption {
        type = types.attrsOf types.anything;
        description = mdDoc "The set of inputs to pin";
      };
    };

    config.nix.registry = let
      mkPin = name: value: { ${name}.flake = value; };
    in concatMapAttrs mkPin config.pins.inputs;
  };
};

}
