#!/bin/bash
clear
sleep 1



# Fungsi untuk menampilkan menu utama
show_menu() {
    echo "========================================="
    echo "             Adduser Tools               "
    echo "========================================="
    sleep 1
    echo "1. Tambahkan pengguna baru"
    echo "2. Ubah shell login pengguna"
    echo "3. Tambahkan pengguna ke grup"
    echo "4. Kunci akun pengguna"
    echo "5. Buka kunci akun pengguna"
    echo "6. Hapus pengguna"
    echo "7. Tampilkan informasi pengguna"
    echo "8. Keluar"
    echo "========================================="
    echo -n "Pilih opsi [1-8]: "
}

# Fungsi untuk menambahkan pengguna baru
add_user() {
    read -p "Masukkan nama pengguna baru: " username
    read -p "Masukkan direktori home (default: /home/$username): " home_dir
    home_dir=${home_dir:-/home/$username}
    read -p "Masukkan shell login (default: /bin/bash): " shell
    shell=${shell:-/bin/bash}

    sudo adduser --home "$home_dir" --shell "$shell" "$username" && echo "Pengguna $username berhasil ditambahkan" || echo "Gagal menambahkan pengguna"
}

# Fungsi untuk mengubah shell login pengguna
change_shell() {
    read -p "Masukkan nama pengguna: " username
    read -p "Masukkan shell baru (contoh: /bin/bash): " shell
    sudo usermod -s "$shell" "$username" && echo "Shell login untuk $username berhasil diubah menjadi $shell" || echo "Gagal mengubah shell"
}

# Fungsi untuk menambahkan pengguna ke grup
add_user_to_group() {
    read -p "Masukkan nama pengguna: " username
    read -p "Masukkan nama grup: " groupname
    sudo usermod -aG "$groupname" "$username" && echo "Pengguna $username berhasil ditambahkan ke grup $groupname" || echo "Gagal menambahkan pengguna ke grup"
}

# Fungsi untuk mengunci akun pengguna
lock_user() {
    read -p "Masukkan nama pengguna: " username
    sudo usermod -L "$username" && echo "Akun $username berhasil dikunci" || echo "Gagal mengunci akun"
}

# Fungsi untuk membuka kunci akun pengguna
unlock_user() {
    read -p "Masukkan nama pengguna: " username
    sudo usermod -U "$username" && echo "Akun $username berhasil dibuka" || echo "Gagal membuka akun"
}

# Fungsi untuk menghapus pengguna
delete_user() {
    read -p "Masukkan nama pengguna yang akan dihapus: " username
    read -p "Hapus direktori home juga? (y/n): " delete_home
    if [[ $delete_home == "y" || $delete_home == "Y" ]]; then
        sudo deluser --remove-home "$username" && echo "Pengguna $username dan direktori home berhasil dihapus" || echo "Gagal menghapus pengguna"
    else
        sudo deluser "$username" && echo "Pengguna $username berhasil dihapus" || echo "Gagal menghapus pengguna"
    fi
}

# Fungsi untuk menampilkan informasi pengguna
show_user_info() {
    read -p "Masukkan nama pengguna: " username
    id "$username" && grep "^$username" /etc/passwd || echo "Pengguna tidak ditemukan"
}

# Main program
while true; do
    show_menu
    read choice
    case $choice in
        1) add_user ;;
        2) change_shell ;;
        3) add_user_to_group ;;
        4) lock_user ;;
        5) unlock_user ;;
        6) delete_user ;;
        7) show_user_info ;;
        8) echo "Keluar..."; exit 0 ;;
        *) echo "Pilihan tidak valid!" ;;
    esac
    echo ""
done
