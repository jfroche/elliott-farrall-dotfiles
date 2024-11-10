{ ...
}:

_final: prev:
{
  android-tools = prev.symlinkJoin {
    name = "android-tools";
    paths = [ prev.android-tools ];
    buildInputs = [ prev.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/adb \
        --set HOME \$XDG_DATA_HOME/android
    '';
  };
}
