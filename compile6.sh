nasm -f bin -o boot1.bin boot1.asm
dd status=noxfer conv=notrunc if=boot1.bin of=boot1.flp
qemu-system-i386 -fda  boot1.flp
mkisofs -o boot1.iso -b boot1.flp cdiso/
