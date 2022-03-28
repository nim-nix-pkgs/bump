{
  description = ''a tiny tool to bump nimble versions'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-bump-1_8_26.flake = false;
  inputs.src-bump-1_8_26.ref   = "refs/tags/1.8.26";
  inputs.src-bump-1_8_26.owner = "disruptek";
  inputs.src-bump-1_8_26.repo  = "bump";
  inputs.src-bump-1_8_26.type  = "github";
  
  inputs."github-disruptek-cutelog".owner = "nim-nix-pkgs";
  inputs."github-disruptek-cutelog".ref   = "master";
  inputs."github-disruptek-cutelog".repo  = "github-disruptek-cutelog";
  inputs."github-disruptek-cutelog".dir   = "1_1_2";
  inputs."github-disruptek-cutelog".type  = "github";
  inputs."github-disruptek-cutelog".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github-disruptek-cutelog".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/disruptek/testes".owner = "nim-nix-pkgs";
  inputs."github.com/disruptek/testes".ref   = "master";
  inputs."github.com/disruptek/testes".repo  = "github.com/disruptek/testes";
  inputs."github.com/disruptek/testes".dir   = "";
  inputs."github.com/disruptek/testes".type  = "github";
  inputs."github.com/disruptek/testes".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/disruptek/testes".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."cligen".owner = "nim-nix-pkgs";
  inputs."cligen".ref   = "master";
  inputs."cligen".repo  = "cligen";
  inputs."cligen".dir   = "v1_5_23";
  inputs."cligen".type  = "github";
  inputs."cligen".inputs.nixpkgs.follows = "nixpkgs";
  inputs."cligen".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-bump-1_8_26"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-bump-1_8_26";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}