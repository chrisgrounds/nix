{ ... }:
{
  programs.dankMaterialShell = {
    enable = true;

    niri = {
      enableSpawn = true; # Auto-start DMS with niri
    };
    enableDynamicTheming = true;

  };
}
