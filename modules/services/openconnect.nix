{ config, lib, pkgs, ... }:

{
  networking.openconnect.interfaces = {
    university = {
      gateway = "vpn.uni-leipzig.de";
      protocol = "anyconnect";
      user = "mb18cele@uni-leipzig.de";
      # NOTE file content as follows:
      # <my_password>
      # "1-Standard-Uni" or "2-Spezial-Alles"
      # Explanation:
      # 1-Standard-Uni = Uni Dienste über VPN (Standard)
      # 2-Spezial-Alles = Gesamter Datenverkehr über VPN (Spezial)
      passwordFile = "/run/agenix/uniVPN";
    };
  };
  age.secrets.uniVPN = {
    file = ../../secrets/uni-vpn.age;
    owner = "1000";
  };
}
