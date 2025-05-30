{ config, pkgs, ... }:
{
  users.users.root.hashedPassword = "$y$j9T$4pjJ6t/Zxlmsx/DhkXNcs/$wus9h1pAYr.8E7DAz0tXmfZHrsd48NZyp88hUDBY/WC";
  users.users.skin = {
    hashedPassword = "$y$j9T$yWiuURe5Q.8da1kNvrVhq.$ejegbxVAg4YOOXkyvQrLVyAo95jSY45yUlQOMtXp3f8";
    isNormalUser = true;
    description = "Daniel Jay Haskin";
    extraGroups = [ "networkmanager" "wheel" "docker" "lpadmin" "disk" "audio" "video" "libvirtd" "input" "network" ];
    uid = 1000;
  };
}
