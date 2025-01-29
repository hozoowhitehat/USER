#!/bin/bash

# Tools Usermod Management
# Pastikan script ini dijalankan dengan hak akses root (sudo)

# Cek apakah script dijalankan dengan sudo
if [[ $EUID -ne 0 ]]; then
    echo "Script ini harus dijalankan dengan sudo!"
    exit 1
fi

# Menu
echo "==================================="
echo "       User Management Tools       "
echo "==================================="
echo "1. Tambah Pengguna"
echo "2. Hapus Pengguna"
echo "3. Ubah Grup Pengguna"
echo "4. Nonaktifkan Pengguna"
echo "5. Aktifkan Pengguna"
echo "6. Ubah Password Pengguna"
echo "7. Tampilkan Daftar Pengguna"
echo "8. Keluar"
echo "==================================="

# Masukkan Pilihan
read -p "Masukkan pilihan Anda [1-8]: " pilihan

# Proses Pilihan
case $pilihan in
1)
    read -p "Masukkan nama pengguna baru: " username
    read -p "Masukkan grup (default: users): " group
    group=${group:-users}
    useradd -m -g $group $username
    echo "Pengguna $username telah ditambahkan."
    ;;
2)
    read -p "Masukkan nama pengguna yang akan dihapus: " username
    userdel -r $username
    echo "Pengguna $username telah dihapus."
    ;;
3)
    read -p "Masukkan nama pengguna: " username
    read -p "Masukkan grup baru: " group
    usermod -g $group $username
    echo "Grup pengguna $username telah diubah ke $group."
    ;;
4)
    read -p "Masukkan nama pengguna yang akan dinonaktifkan: " username
    usermod -L $username
    echo "Pengguna $username telah dinonaktifkan."
    ;;
5)
    read -p "Masukkan nama pengguna yang akan diaktifkan: " username
    usermod -U $username
    echo "Pengguna $username telah diaktifkan."
    ;;
6)
    read -p "Masukkan nama pengguna yang akan diubah passwordnya: " username
    passwd $username
    ;;
7)
    echo "Daftar pengguna:"
    cut -d: -f1 /etc/passwd
    ;;
8)
    echo "Keluar."
    exit 0
    ;;
*)
    echo "Pilihan tidak valid. Silakan coba lagi."
    ;;
esac
