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

    config = {
      nix.registry = let
        mkPin = name: value: { ${name}.flake = value; };
      in concatMapAttrs mkPin config.pins.inputs;

      nix.nixPath = let
        mkPin = name: _: "${name}=flake:${name}";
      in mapAttrsToList mkPin config.pins.inputs;

      assertions = [
        {
          assertion = all (isType "flake") (attrValues config.pins.inputs);
          message = "'pins.inputs' needs to be an attribute set of flakes";
        }
      ];
    };
  };
};

}
