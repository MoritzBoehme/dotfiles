{ config, lib, pkgs, ... }:

{
 services.davfs2.enable = true;
 services.autofs = {
   autoMaster =
     let
       mapConf = pkgs.writeText "auto" ''
         keepass -fstype=favfs,conf=
       '';
     in
       ''
         /auto file:${mapConf}
       '';
 };
}
