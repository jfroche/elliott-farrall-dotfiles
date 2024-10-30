{ ...
}:

{
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
  boot.loader.grub.device = "/dev/sda";

  swapDevices = [{
    device = "/swapfile";
    size = 4 * 1024; # 4GB
  }];
}
