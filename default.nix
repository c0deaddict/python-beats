with import <nixpkgs> {};

let dependencies = rec {
  _sounddevice = with python36Packages; sounddevice.overrideAttrs (oldAttrs: {
    name = "sounddevice";
    prePatch = ''
      substituteInPlace src/sounddevice.py --replace "_find_library('portaudio')" "'${portaudio}/lib/libportaudio.so.2'"
    '';
  });
};

in with dependencies;
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
    _sounddevice
  ];

  shellHook = ''
  '';
}
