{
  description = ''a tiny tool to bump nimble versions'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-bump-1_8_19.flake = false;
  inputs.src-bump-1_8_19.ref   = "refs/tags/1.8.19";
  inputs.src-bump-1_8_19.owner = "disruptek";
  inputs.src-bump-1_8_19.repo  = "bump";
  inputs.src-bump-1_8_19.type  = "github";
  
  inputs."cligen".owner = "nim-nix-pkgs";
  inputs."cligen".ref   = "master";
  inputs."cligen".repo  = "cligen";
  inputs."cligen".dir   = "v1_5_25";
  inputs."cligen".type  = "github";
  inputs."cligen".inputs.nixpkgs.follows = "nixpkgs";
  inputs."cligen".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/disruptek/cutelog".owner = "nim-nix-pkgs";
  inputs."github.com/disruptek/cutelog".ref   = "master";
  inputs."github.com/disruptek/cutelog".repo  = "github.com/disruptek/cutelog";
  inputs."github.com/disruptek/cutelog".dir   = "";
  inputs."github.com/disruptek/cutelog".type  = "github";
  inputs."github.com/disruptek/cutelog".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/disruptek/cutelog".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-bump-1_8_19"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-bump-1_8_19";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}