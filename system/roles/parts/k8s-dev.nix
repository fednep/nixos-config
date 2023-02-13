{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    jq
    tmux
    kubectl
    eksctl
    awscli2
    kubernetes-helm
  ];

}
