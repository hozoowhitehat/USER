#!/bin/bash
clear
sleep 1
#!/bin/bash

# Fungsi untuk menampilkan menu
show_menu() {
    echo "======================================"
    echo "           Usermod Tools              "
    echo "======================================"
    sleep 1
    echo "1. Tambahkan pengguna ke grup"
    echo "2. Hapus pengguna dari grup"
    echo "3. Ubah shell login pengguna"
    echo "4. Kunci (lock) akun pengguna"
    echo "5. Buka kunci (unlock) akun pengguna"
    echo "6. Tampilkan informasi pengguna"
    echo "7. Keluar"
    echo "======================================"
    echo -n "Pilih opsi [1-7]: "
}

# Fungsi untuk menambah pengguna ke grup
add_user_to_group() {
    read -p "Masukkan nama pengguna: " username
    read -p "Masukkan nama grup: " groupname
    usermod -aG "$groupname" "$username" && echo "Berhasil menambahkan $username ke grup $groupname" || echo "Gagal menambahkan pengguna"
}

# Fungsi untuk menghapus pengguna dari grup
remove_user_from_group() {
    read -p "Masukkan nama pengguna: " username
    read -p "Masukkan nama grup: " groupname
    gpasswd -d "$username" "$groupname" && echo "Berhasil menghapus $username dari grup $groupname" || echo "Gagal menghapus pengguna"
}

# Fungsi untuk mengubah shell pengguna
change_user_shell() {
    read -p "Masukkan nama pengguna: " username
    read -p "Masukkan shell baru (contoh: /bin/bash): " shell
    usermod -s "$shell" "$username" && echo "Shell pengguna $username diubah menjadi $shell" || echo "Gagal mengubah shell"
}

# Fungsi untuk mengunci akun
lock_user_account() {
    read -p "Masukkan nama pengguna: " username
    usermod -L "$username" && echo "Akun $username berhasil dikunci" || echo "Gagal mengunci akun"
}

# Fungsi untuk membuka kunci akun
unlock_user_account() {
    read -p "Masukkan nama pengguna: " username
    usermod -U "$username" && echo "Akun $username berhasil dibuka" || echo "Gagal membuka akun"
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
        1) add_user_to_group ;;
        2) remove_user_from_group ;;
        3) change_user_shell ;;
        4) lock_user_account ;;
        5) unlock_user_account ;;
        6) show_user_info ;;
        7) echo "Keluar..."; exit 0 ;;
        *) echo "Pilihan tidak valid!" ;;
    esac
    echo ""
done
