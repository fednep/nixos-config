{ pkgs, ... }:
{

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;

  # Define a user account.
  users.users.fedir = {
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    hashedPassword = "$6$HbmKJ9X/Mtl7xTl8$ADp3i4prozbYsW7zik7BBkqu0ZZJPewVm9VoryI10Nww3ifwAXm9QIO6jjttfoXXyIrg/wCbzzmCoGtDTUBgt0";
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDD5YU7HVVdocDLyWMPmcjlDx0z6NGuTJkkkJKxJzLX15ruU5wwdU0+gly4KJacJ2Mj8OEreMq7u1mDOcV8f4IyEGYpy6g2Qfurg0iZ97O8xvwcCVbOXrz4GLAAtbPkXzpApm/O002oWO+qLxz4LvaVrL9M2w+w2Sxpj0JfggKS5Uxp5RfS5bnTjtANdLpm10ev1EFtVM6H0chTkVH/YpZEqKMAOgNk+v5LFhe9xQPw1s+9fUvnDmU9GKq7FApYModTnh5sgt4Agi1tGPZM/wpUuH/G70En1GizPjpaiGcjuGF/+RNq7OHbrt/ed5WnCezo0OZ7b1zYyBFlYBiSkRot mbp" ];
  };

}
