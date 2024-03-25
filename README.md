# Laporan Pengerjaan - Praktikum 1 Sistem Operasi
## Kelompok IT05 - MH
Fikri Aulia As Sa'adi - 5027231026

Aisha Ayya Ratiandari - 5027231056

Gandhi Ert Julio - 5027231081

### _Soal 1_
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

[![Hasil Ketika Menjalankan sandbox.sh](https://i.im.ge/2024/03/25/WXc0E4.Screenshot-from-2024-03-25-20-09-38.th.png)](https://im.ge/i/Screenshot-from-2024-03-25-20-09-38.WXc0E4)

### Soal 2
### Soal 3
### Soal 4
