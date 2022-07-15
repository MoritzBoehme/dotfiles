{ config
, lib
, pkgs
, ...
}:

{
  imports = [
    ./config
    ./programs
    ./security
    ./services
    ./virtualisation
  ];
}
