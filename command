sudo parted /dev/nvme0n1 -- mklabel gpt
sudo parted /dev/nvme0n1 -- mkpart primary 512MiB -8GiB
sudo parted /dev/nvme0n1 -- mkpart primary linux-swap -8GiB 100%
sudo parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/nvme0n1 -- set 3 esp on
sudo mkfs.ext4 -L nixos /dev/nvme0n1p1
sudo mkswap -L swap /dev/nvme0n1p2
sudo mkfs.fat -F 32 -n boot /dev/nvme0n1p3
sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
sudo swapon /dev/nvme0n1p2
nixos-generate-config --root /mnt
