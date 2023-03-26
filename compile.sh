nasm -f bin -o boot.bin boot.asm
dd status=noxfer conv=notrunc if=boot.bin of=boot.flp
qemu-system-i386 -fda boot.flp
mkisofs -o boot.iso  boot.flp cdiso
