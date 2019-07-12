with import "/home/jos/Projects/Nix/nixpkgs" {};

stdenv.mkDerivation rec {
  name = "env";

  env = buildEnv { name = name; paths = buildInputs; };
  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup; ln -s $env $out
  '';

  buildInputs = [
    portaudio
    python36
    python36Packages.numpy
    python36Packages.matplotlib
    python36Packages.ipython_6
    python36Packages.pyqt5
    python36Packages.sounddevice
  ];

  shellHook = ''
  '';
}
