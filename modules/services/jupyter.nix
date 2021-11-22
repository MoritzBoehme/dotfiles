{ config, lib, pkgs, ... }:

{
  # Create jupyter user
  users.users.jupyter.group = "jupyter";
  users.users.jupyter.isSystemUser = true;
  users.groups.jupyter = { };

  services.jupyter = {
    enable = true;
    password =
      "'argon2:$argon2id$v=19$m=10240,t=10,p=8$rILNOtQ9WhacuEhV5zW2CQ$Gvbql8TEqBxPhKeMVwKZPQ'";
    kernels = {
      python3 =
        let
          env = pkgs.python3.withPackages (pythonPackages:
            with pythonPackages; [
              ipykernel
              pandas
              scikit-learn
            ]);
        in
        {
          displayName = "Python 3 for machine learning";
          argv = [
            "${env.interpreter}"
            "-m"
            "ipykernel_launcher"
            "-f"
            "{connection_file}"
          ];
          language = "python";
          logo32 = null;
          logo64 = null;
        };
    };
  };
}
