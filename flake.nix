{
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      inherit (nixpkgs.legacyPackages.${system}) pkgs;
    in
    {
      devShell.${system} = pkgs.mkShell { buildInputs = [ pkgs.hugo ]; };

      defaultPackage.${system} = self.packages.${system}.serve;

      packages.${system} =
        {
          serve = pkgs.writeShellScriptBin "serve" "exec ${pkgs.hugo}/bin/hugo serve";
          build = pkgs.writeShellScriptBin "build" "exec ${pkgs.hugo}/bin/hugo --cleanDestinationDir";
        };
    };
}
