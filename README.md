<div align=center>

# Laporan Pengerjaan - Praktikum 1 Sistem Operasi

</div>


## Kelompok IT05 - MH
Fikri Aulia As Sa'adi - 5027231026

Aisha Ayya Ratiandari - 5027231056

Gandhi Ert Julio - 5027231081

## _Soal 1_
### Dikerjakan Oleh Fikri Aulia As Sa'adi (5027231026)
Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan.

Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe 

a. Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi

b. Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit paling kecil. Tampilkan customer segment yang memiliki profit paling kecil

c. Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi 

d. Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens

## Penyelesaian
```
#!/bin/bash

#Soal Shift Modul 1 - Sistem Operasi
#Kelompok IT05

# Langkah persiapan :
# a.Download file Sandbox.csv dari link yang disediakan
curl -L -o Sandbox.csv 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'
# b. Membuka file Sandbox.csv
open Sandbox.csv


# Langkah pengerjaan : 
# a. Mencari nama pembeli dengan sales tertinggi dari file Sandbox.csv
res_a=$(sort -t ',' -k 17 -nr Sandbox.csv | head -n 1 | cut -d ',' -f 6,17)

# b. Mencari customer segment dengan profit paling kecil dari file Sandbox.csv
res_b=$(sort -t ',' -k 20 -n Sandbox.csv | awk -F ',' 'NR==2{print $7, $20}')

# c. Mencari 3 kategori dengan profit paling tinggi dari file Sandbox.csv
res_c=$(awk -F ',' 'NR>1{print $14","$20}' Sandbox.csv | sort -t ',' -k 2 -nr | head -3)

# d. Mencari purchase date dan quantity dari pesanan milik adriaens
res_d=$(grep -i "adriaens" Sandbox.csv | cut -d ',' -f 2,18,6)

# Output hasilnya
echo -e "a. Pembeli dengan sales tertinggi dan total salesnya adalah:\n$res_a"
echo -e "b. Customer segment dengan profit paling kecil dan total profitnya adalah:\n$res_b "
echo -e "c. Tiga kategori yang memiliki profit tertinggi dan masing-masing profitnya adalah:\n$res_c"
echo -e "d. Purchase date dan amount dari pesanan milik adriaens adalah:\n$res_d"``
```
### Penjelasan
#### _1. Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan._

#### _Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe_

- Langkah pertama untuk mengerjakan no.1 adalah mendownload file "Sandbox.csv" dari link yang telah disediakan

`
curl -L -o Sandbox.csv 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'
`

- Dikarenakan file .csv apabila dibuka langsung di terminal akan susah dibaca, maka kita akan buka file Sandbox.csv dengan aplikasi eksternal. Disini saya menggunakan aplikasi Modern CSV

`
open Sandbox.csv
`

#### _a. Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi_

- Langkah pertama untuk menampilkan total sales paling tinggi, kita harus mengurutkan data sales yang terdapat pada file Sandbox.csv kolom 17 menggunakan "sort"
- Selanjutnya gunakan command "head -n 1" untuk mengambil input pertama dari command sebelumnya
- Terakhir, command "cut" digunakan untuk mengambil bagian yang akan ditampilkan nantinya

`
sort -t ',' -k 17 -nr Sandbox.csv | head -n 1 | cut -d ',' -f 6,17
`

#### _b. Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit paling kecil. Tampilkan customer segment yang memiliki profit paling kecil_

- Langkah pertama adalah dengan mengurutkan data profit yang ada di kolom 20 menggunakan command "sort".
- Selanjutnya gunakan awk NR untuk memilih customer segment (kolom 7) yang memiliki profit (kolom 20) paling rendah.
`
sort -t ',' -k 20 -n Sandbox.csv | awk -F ',' 'NR==2{print $7, $20}'
`

#### _c. Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi_

- Langkah pertama adalah menggunakan awk untuk memilih baris kedua ke bawah dari kolom kategori (14) dan kolom profit (20) untuk diproses selanjutnya
- Kemudian urutkan data dari kolom yang sudah dipilih sebelumnya
- Terakhir gunakan "head -3" untuk mengeluarkan tiga output teratas

`
awk -F ',' 'NR>1{print $14","$20}' Sandbox.csv | sort -t ',' -k 2 -nr | head -3
`

#### _d. Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens_

- Untuk mengecek pesanan, bisa menggunakan command "grep"
- Kemudian gunakan command "cut" untuk menampilkan hasil dari pencarian tepatnya kolom order id (1), kolom customer name (6) dan kolom quantity (18) 

`
grep -i "adriaens" Sandbox.csv | cut -d ',' -f 2,6,18
`

### Dokumentasi

![image](https://github.com/Gandhiert/Sisop-1-2024-MH-IT05/assets/142889150/90b937cf-d413-41c3-8426-bf65ce85def4)
>File Sandbox.csv ketika dibuka menggunakan terminal


![image](https://github.com/Gandhiert/Sisop-1-2024-MH-IT05/assets/142889150/a262d783-adb0-49b7-b98e-72f53a67e8c7)
>File Sandbox.csv ketika dibuka menggunakan Modern CSV


![image](https://github.com/Gandhiert/Sisop-1-2024-MH-IT05/assets/142889150/9511b736-4922-4e2f-86c1-465fe174b1d0)
>Hasil ketika menjalankan sandbox.sh



## _Soal 2_
Dikerjakan oleh Aisha Ayya Ratiandari-5027231056

Nomor ini diminta untuk membuat menu register dengan ketentuan berikut:
- Setiap admin maupun user harus melakukan register terlebih dahulu menggunakan email, username, pertanyaan keamanan dan jawaban, dan password
- dimana setiap akunnya akan disimpan dalam file users.txt
- lalu diminta untuk membuat menu login dengan pilihan untuk login, atau jika lupa password
- jika login dengan akun admin, maka munculkan menu admin dengan isi:
  - Add user
  - Edit user
  - Remove user
  - Logout
- Semua registrasi dan login akan direkap ke dalam file auth.log

### Membuat menu Register di file register.sh
1. Kita membuat function untuk memastikan kalau email yang diinputkan user itu unik (belum diinputkan sebelumnya)
   mengambil data email (variabel) dari file users.txt dan jika sudah pernah dipakai maka return 0, jika belum maka return 1
   ```
    function check_email() {
        local email="$1" # bikin variabel "email"
        if grep -q "^$email:" users.txt; then
            return 0 # Email udah dipake
        else
            return 1 # Email belum dipake
        fi
    }
    ```
2. Membuat function untuk mengenkripsi password menggunakan base 64 dengan mengambil password dari input user lalu mengenkripsikannya dengan base64 tanpa membuat line baru
   ```
   function encrypt_password() {
        local password="$1"
        local encrypted_password=$(echo -n "$password" | base64)
        echo "$encrypted_password"
    }
   ```
4. Membuat function untuk membuat akun barunya
   - menggunakan variabel berupa email, username, security question, security answer, dan password
    ```
    function register() {
        local email="$1"
        local username="$2"
        local security_question="$3"
        local security_answer="$4"
        local password="$5"
    ```
   - mengecek apakah email yang diinputkan pernah dipakai sebelumnya, menggunakan function "check_email"
     ```
     if check_email "$email"; then
        echo "Email sudah terpakai."
        exit 1
     fi
     ```
   - Mengecek apakah password yang dibuat memenuhi kriteria menggunakan loop. Jika password yang diinput tidak memenuhi kriteria, maka lakukan loopnya hingga password user memenuhi kriteria
    ```
   while true; do
        read -s -p "Enter password: " password
        echo

        # Kalau ngga, suruh ulang
        if [[ "$password" =~ [[:upper:]] && "$password" =~ [[:lower:]] && "$password" =~ [[:digit:]] && ${#password} -ge 8 ]]; then
            break  # Berhentiin loop klau udah memenuhi kriteria
        else
            echo "Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, and be at least 8 characters long."
            echo "Please try again."
        fi
    done
    ```
   - Password tersebut akan dienkripsi menggunakan function "encrypt_password" dan akan disimpan dalam variabel "encrypted_password"
     ```
     local encrypted_password=$(encrypt_password "$password")
     ```
   - Cek apakah user menginput email sebagai admin, sesuai soal dimana email mengandung kata admin maka akun tersebut akan bertipe admin, jika tidak maka akan menjadi tipe "user"
     ```
        if [[ "$email" == *"admin"* ]]; then
            user_type="admin"
        else
            user_type="user"
        fi
     ```
   - Terakhir, tambahkan informasi user ke file users.txt lalu menampilkan output "Registrasi berhasil" dan merekapnya ke dalam file auth.log
    ```
    echo "$email:$username:$security_question:$security_answer:$encrypted_password:$user_type" >>/Users/rrrreins/sisop/mod1-soal2/users.txt
    echo "Registration successful."
    echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER SUCCESS] Registrasi user $username berhasil." >>/Users/rrrreins/sisop/mod1-soal2/auth.log
    ```
6. Dalam main script, kita akan mengoutputkan beberapa line seperti "selamat datang", meminta email, username, security question, security answer
    ```
   echo "Welcome to Registration System"
        read -p "Enter email: " email
        read -p "Enter username: " username
        read -p "Enter security question: " security_question
        read -p "Enter security answer: " security_answer
    echo
    ```
8. Lalu input user tersebut akan kita balikkan ke function register
    ```
   register "$email" "$username" "$security_question" "$security_answer" "$password"
    ```
Maka jika kita panggil, akan muncul seperti ini:


### Membuat Menu Login di file login.sh
1. Bikin fungsi untuk mastiin kalau informasi user sudah terbuat sebelumnya
   - Mencari informasi user di file users.txt, kalau ga nemu, kembali ke menu awal dengan output "User tidak ditemukan"
     ```
         local email="$1"
        local password="$2"

        local user_info=$(grep "^$email:" /Users/rrrreins/sisop/mod1-soal2/users.txt)

	
        if [ -z "$user_info" ]; then
        echo "User with email $email not found."
        exit 1
        fi
     ```
   - Menyamakan password yang diinputkan dengan yang sudah tersimpan, dengan mengambil informasi password dari data yang masih dienkripsi yang kemudian Password tersebut akan kita dekripsi pake base64 lagi
       ```
        local encrypted_password=$(echo "$user_info" | cut -d: -f5)

        local decrypted_password=$(echo "$encrypted_password" | base64 -d)
       ```
   - Cek apakah password yang diinputkan user sama dengan password yang tersimpan, jika salah maka kembali ke menu awl dan tampilkan output "Password salah"
     ```
         if [ "$password" != "$decrypted_password" ]; then
            echo "Incorrect password."
            exit 1
        fi
     ```
   - Cek apakah user menginputkan akun admin, jika bukan munculkan output "User berhasil login" dan kembali ke menu awal
     ```
            local user_type=$(echo "$user_info" | cut -d: -f6)
        if [ "$user_type" != "admin" ]; then
            echo "User $email berhasil login!"
            exit 1
        fi
     ```
   - Mengoutputkan hasil login (apakah berhasil atau gagal) ke dalam file auth.log beserta waktu dan tanggalnya. Kemudian masuk ke dalam function admin_menu dengan menggunakan variabel "email"
     ```
     echo "Login successful!"
        echo "$(date '+[%d/%m/%y %H:%M:%S]') [LOGIN SUCCESS] User $email berhasil log in." >> /Users/rrrreins/sisop/mod1-soal2/auth.log
		
		admin_menu "$email"
		return 0
        }
     ```
3. Bikin fungsi untuk ospi lupa password
    ```
   function forgot_password() {
    local email="$1"
    ```
   - cari usernya menggunakan input email di users.txt, kalau ga ketemu, balik ke menu awal dan mengoutputkan "User tidak ditemukan"
     ```
        local user_info=$(grep "^$email:" /Users/rrrreins/sisop/mod1-soal2/users.txt)

        if [ -z "$user_info" ]; then
            echo "User with email $email not found."
            return 1
        fi
     ```
   - kalau berhasil, ambil informasi security question dari data lalu prompt ke user untuk memberikan jawaban yang tepat. Ambil informasi security answer dari data lalu cek apakah jawaban yang diinputkan user sama dengan yang ada di data. Jika tidak maka akan menampilkan "Incorrect answer" dan kembali ke menu awal
     ```
     local security_question=$(echo "$user_info" | cut -d: -f3)

     read -p "Security Question: $security_question " provided_security_answer

     local stored_security_answer=$(echo "$user_info" | cut -d: -f4)

     if [ "$provided_security_answer" != "$stored_security_answer" ]; then
     echo "Incorrect answer."
     return 1
     fi
     ```
   - jika benar maka tampilkan passowrd user yang masih di-enkripsi lalu didekripsi menggunakan function decrypted password dan tampilkan hasilnya
     ```
     local encrypted_password=$(echo "$user_info" | cut -d: -f5)
     local decrypted_password=$(echo "$encrypted_password" | base64 -d)
     echo "Your password is: $decrypted_password"
     return 0
     }
     ```
5. Buat function untuk menampilkan menu admin
   Menampilkan tampilan admin menu berupa add, edit, dan remove user, juga untuk logout. Lalu menggunakan case untuk memilih salah satu opsi yang tersedia, semua dilakukan dalam loop dan berhenti jika sudah memilih opsinya
   ```
   function admin_menu() {
       local email="$1"
       while true; do
        
        echo "Admin Menu"
        echo "1. Add User"
        echo "2. Edit User"
        echo "3. Remove User"
        echo "4. Logout"
        read -p "Choose an option: " admin_option

        case $admin_option in
            1)
                add_user
                ;;
            2)
                read -p "Enter user's email to edit: " edit_email
                edit_user "$edit_email"
                ;;
            3)
                read -p "Enter user's email to remove: " remove_email
                remove_user "$remove_email"
                ;;
            4)
                echo "Logging out..."
                exit 0
                ;;
            *)
                echo "Invalid option. Please choose again."
                ;;
        esac
    done
    }
   ```
   dalam kode di atas kita menggunakan statement case untuk memberi opsi kepada user untuk memilih opsi yang telah disediakan,
   jika memilih opsi pertama maka akan diarahkan ke function add_user
   jika memilih opsi ke-2 dan ke-3 maka akan diminta untuk meng-inputkan email lalu diarahkan ke function edit_user dan remove_user menggunakan email tersebut
   dan jika memilih opsi terakhir, maka akan dikeluarkan dari program
   - Membuat function untuk add user
     dengan mengarahkannya ke menu register yang sudah dibuat sebelumnya
     ```
     /Users/rrrreins/sisop/mod1-soal2/register.sh
     ```
   - Membuat function untuk mengedit user
     disini mengedit hanya bisa untuk mengganti username dan password
     mengecek apakah user terdaftar dalam users.txt
     ```
     if grep -q "^$email:" /Users/rrrreins/sisop/mod1-soal2/users.txt; then
        read -p "Enter new username (leave blank to keep current): " new_username
        read -s -p "Enter new password (leave blank to keep current): " new_password
        echo # Move to a new line after entering password
     ```
     untuk membuat username baru (jika ingin masih sama, bisa dilewatkan) dan untuk untuk membuat password baru(jika ingin masih sama, bisa dilewatkan)
     ```
     if [ -n "$new_username" ]; then
         sed -i "s/^$email:[^:]*:/&$new_username:/" /Users/rrrreins/sisop/mod1-soal2/users.txt
         echo "Username updated successfully for $email."
     fi

     if [ -n "$new_password" ]; then
         # Encrypt the new password
         local encrypted_password=$(encrypt_password "$new_password")
         # Update the password in the file
         sed -i "s/^$email:[^:]*:[^:]*:/&$encrypted_password:/" /Users/rrrreins/sisop/mod1-soal2/users.txt
         echo "Password updated successfully for $email."
     fi
     ```
   - Membuat function untuk me-remove user
     ```
     function remove_user() {
     local email="$1"
    
     if grep -q "^$email:" /Users/rrrreins/sisop/mod1-soal2/users.txt; then
         # Remove user from users.txt
         sed -i "/^$email:/d" /Users/rrrreins/sisop/mod1-soal2/users.txt
         echo "User with email $email removed successfully."
     else
        echo "User with email $email not found."
     fi
     }
     ```
     dalam kode diatas, kita membuat functioun untuk menghapus user. Setelah mengecek apakah email yang diinputkan sesuai, maka akan menghapus user yang tersimpan datanya di users.txt dimana jika berhasil maka akan menghasilkan output "User telah berhasil dihapus"
7. Dalam main script, kita akan mengoutputkan beberapa line seperti "selamat datang", opsi Login dan Forgot Password
    ```
    echo "Welcome to Login System"
    echo "1. Login"
    echo "2. Forgot Password"
    read -p "Enter your choice: " choice
    ```
   - jika memilihi opsi "login" maka usr akan diminta untuk menampilkan email dan passwordnya, yang lalu, menggunakan function authenticate_user, untuk mengecek apakah user sudah terbuat atau belum
   - jika memilih opsi "Forgot Password" maka user akan diminta untuk meng-input emailnya yanag akan di proses melalui function "forgot_password"
     ```
        case $choice in
        1)
            # Login option selected
            read -p "Enter email: " email
            read -s -p "Enter password: " password
            echo
            authenticate_user "$email" "$password"
            ;;
        2)
            # Forgot Password option selected
            read -p "Enter email: " email
            forgot_password "$email" 
            ;;
        *)
            echo "Invalid choice. Please select 1 or 2."
            ;;
	    esac
     ```
## _Soal 3_
### Dikerjakan Oleh Gandhi Ert Julio (5027231081)
Soal nomor 3 ini berfokus pada manipulasi dan otomatisasi tugas-tugas terkait dengan file yang diunduh dari sebuah game, yang di sini menggunakan contoh dari game Genshin Impact. Soal ini melibatkan pengetahuan tentang skrip bash, handling file di Linux, decoding dari hexadecimal, dan automasi dengan cron jobs. Untuk menangani soal ini, berikut langkah-langkah yang mungkin perlu diambil:
1. Mendekode Nama File Hexadecimal
2. Renaming dan Pengelompokan File
3. Menghitung dan Menampilkan Jumlah Pengguna Senjata
4. Mencari Pesan Tersembunyi dengan search.sh
5. Menghapus File Teks dan Mencatat dalam image.log
6. Pengumpulan Hasil

### awal.sh
```bash
wget -O genshin.zip 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'

unzip genshin.zip
unzip genshin_character.zip
```
potongan kode diatas dalam file awal.sh berfungsi sebagai mengunduh file zip karakter Genshin Impact dari link yang diberikan dan mengekstrak isi file zip yang baru diunduh.
```bash
declare -A weapon_count

current_dir=$(pwd)
character_dir="$current_dir/genshin_character"
csv_file="$current_dir/list_character.csv"
```
lalu potongan kode ini untuk mendeklarasikan associative array untuk menyimpan jumlah senjata dan membuat direktori kerja saat ini untuk menentukan path/lokasi file.
```bash
for jpg_file in "$character_dir"/*.jpg; do
    name_decoded=$(basename "$jpg_file" | xxd -r -p)

    char_region=$(awk -F',' -v char_name="$name_decoded" '$1 == char_name {print $2}' "$csv_file")
    char_elemen=$(awk -F',' -v char_name="$name_decoded" '$1 == char_name {print $3}' "$csv_file")
    char_weapon=$(awk -F',' -v char_name="$name_decoded" '$1 == char_name {print $4}' "$csv_file")

    mkdir -p "$character_dir/$char_region"
    
    if [ -f "$jpg_file" ]; then
        mv "$jpg_file" "$character_dir/$char_region/$char_region-$name_decoded-$char_elemen-$char_weapon.jpg"
    else
        echo "File not found: $jpg_file"
    fi
done
```
baris tersebut berfungsi untuk looping pada setiap file gambar (.jpg) di direktori karakter, mendekode nama file dari format hexadecimal, mencari informasi region, elemen, dan senjata dari file CSV. 
Lalu membuat direktori baru berdasarkan region jika belum ada pada sektor mkdir, dan memindahkan serta merename file gambar sesuai format yang ditentukan.
```bash
# Mendefinisikan jenis senjata dalam game
weapon_kinds=(Bow Polearm Claymore Sword Catalyst)

# Menghitung jumlah karakter untuk setiap jenis senjata
for weapon_kind in "${weapon_kinds[@]}"; do
    weapon_count=$(awk -F',' '/'"$weapon_kind"'/ { ++weapon_count } END { print weapon_count }' "$csv_file")
    echo "$weapon_kind : $weapon_count"
done
```
baris tersebut berfungsi untuk mendefinisikan jenis senjata dalam game dan menghitung jumlah karakter untuk setiap jenis senjata.
![image](https://github.com/Gandhiert/NYOBA/assets/136203533/d746b0ae-cf3b-41fc-b6e9-2d5ab2c821e1)
>Contoh dari hasil run nya akan seperti berikut.
```bash
rm genshin.zip
rm genshin_character.zip
rm list_character.csv
```
command yang terakhir dari shell awal.sh ini digunakan untuk menghapus konten dari file yang telah kita download sebelumnya.
![image](https://github.com/Gandhiert/NYOBA/assets/136203533/00d07833-4f55-4ec2-815c-3e2e41d5b10d)
![image](https://github.com/Gandhiert/NYOBA/assets/136203533/9ad7d710-a1cd-4efe-9706-fb26b31cc289)
![image](https://github.com/Gandhiert/NYOBA/assets/136203533/d8cdfad3-06a6-4d15-9034-f1985ea63e8d)



>hasil akhir dari shell awal.sh akan seperti berikut.


## search.sh
```bash
direktori=$(pwd)
log_path="$direktori/log_image.txt"
txt_dir="$direktori/txt_files"
url_pattern='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'
```
potongan kode tersebut berfungsi sebagai penetapan variabel 'direktori' dengan direktori saat ini dimana skrip dijalankan. Penetapan path untuk file log. Penetapan direktori untuk menyimpan file teks yang diekstrak, dan Membuat pola regex untuk mencocokkan URL.


```bash
touch $log_path
```
membuat file log jika belum ada

```bash
handle_file() {
    local img_file=$1
    mkdir -p $txt_dir
    mv $direktori/*.txt $txt_dir/
```
Di baris ini ada fungsi untuk menangani file, dimulai dari pembuatan direktori file teks dan memindahkan semua file teks ke direktori yang ditentukan.
```bash
    for file_txt in $txt_dir/*.txt; do
        base64 --decode "$file_txt" > secret.txt
        file_content=$(cat secret.txt)

        if [[ $file_content =~ $url_pattern ]]; then

            mv secret.txt $FILE_DIR
            echo "[$(date '+%Y/%M/%d %H:%M:%S')] [FOUND] [$direktori/genshin_character/$file_txt]" >> $log_path
            break
        else
            echo "[$(date '+%Y/%M/%d %H:%M:%S')] [NOT FOUND] [$direktori/genshin_character/$file_txt]" >> $log_path
        fi
        rm "$file_txt"
    done
    sleep 1
}
```
lalu di baris ini ada looping untuk melalui semua file teks di direktori dan dekoding file teks dari base64. Mengecek isi fole teks yang mengandung url dan jika ada URL, simpan file dan catat di log sebagai 'FOUND' atau 'NOT FOUND', serta menghapus file teks yang telah diproses. Kita beri jeda 1 detik untuk penghentian ini.

```bash
regions=("Mondstat" "Liyue" "Fontaine" "Inazuma" "Sumeru")
```
lalu kita membuat array untuk Region yang dibagikan.

```bash
for region in "${regions[@]}"; do
    secret=""
    for img in "$direktori/genshin_character/$region"/*.jpg; do
        steghide extract --quiet --stegofile "$img" --passphrase "$secret"
        handle_file "$img"
    done
done
```
Di baris ini berfungsi untuk looping dari array region yang telah kita buat/susun. Looping melalui setiap gambar di region tersebut, serta mengekstrak "secret.txt" dari gambar menggunakan 'steghide' hingga menangani file yang diekstrak.

```bash
secret_url=$(cat "secret.txt")
wget --output-document=foto_rahasia.jpg "$secret_url"
```
di baris fungsi terakhir dari shell search.sh, ini akan membaca URL rahasia dari file teks "secret.txt" dan mendownload gambar dari URL rahasia yang ditemukan.

![image](https://github.com/Gandhiert/NYOBA/assets/136203533/a30d6e48-dc04-4e31-a9a8-8b800f2a9bb3)
>Foto rahasia

![image](https://github.com/Gandhiert/NYOBA/assets/136203533/c65148d8-22f5-4c98-a774-ecd615ae8fc2)

>Struktur Format Hasil Akhir

![image](https://github.com/Gandhiert/NYOBA/assets/136203533/b289883a-f6f5-4620-966b-9b224d7f1013)

>Format image.log
## _Soal 4_
