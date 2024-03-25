<div align=center>

# Laporan Pengerjaan - Praktikum 1 Sistem Operasi

</div>


## Kelompok IT05 - MH
Fikri Aulia As Sa'adi - 5027231026

Aisha Ayya Ratiandari - 5027231056

Gandhi Ert Julio - 5027231081

### _Soal 1_
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



### Soal 2
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
### Soal 4
