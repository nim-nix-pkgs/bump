{
  description = ''a tiny tool to bump nimble versions'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-bump-1_8_13.flake = false;
  inputs.src-bump-1_8_13.ref   = "refs/tags/1.8.13";
  inputs.src-bump-1_8_13.owner = "disruptek";
  inputs.src-bump-1_8_13.repo  = "bump";
  inputs.src-bump-1_8_13.type  = "github";
  
  inputs."cligen".owner = "nim-nix-pkgs";
  inputs."cligen".ref   = "master";
  inputs."cligen".repo  = "cligen";
  inputs."cligen".dir   = "v1_5_23";
  inputs."cligen".type  = "github";
  inputs."cligen".inputs.nixpkgs.follows = "nixpkgs";
  inputs."cligen".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."git///github.com/disruptek/cutelog".owner = "nim-nix-pkgs";
  inputs."git///github.com/disruptek/cutelog".ref   = "master";
  inputs."git///github.com/disruptek/cutelog".repo  = "git///github.com/disruptek/cutelog";
  inputs."git///github.com/disruptek/cutelog".dir   = "";
  inputs."git///github.com/disruptek/cutelog".type  = "github";
  inputs."git///github.com/disruptek/cutelog".inputs.nixpkgs.follows = "nixpkgs";
  inputs."git///github.com/disruptek/cutelog".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-bump-1_8_13"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-bump-1_8_13";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}