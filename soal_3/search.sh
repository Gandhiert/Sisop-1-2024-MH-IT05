#!/bin/bash

direktori=$(pwd)
log_path="$direktori/log_image.txt"
txt_dir="$direktori/txt_files"
url_pattern='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'

touch $log_path

handle_file() {
    local img_file=$1
    mkdir -p $txt_dir
    mv $direktori/*.txt $txt_dir/

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

regions=("Mondstat" "Liyue" "Fontaine" "Inazuma" "Sumeru")
for region in "${regions[@]}"; do
    secret=""
    for img in "$direktori/genshin_character/$region"/*.jpg; do
        steghide extract --quiet --stegofile "$img" --passphrase "$secret"
        handle_file "$img"
    done
done

secret_url=$(cat "secret.txt")
wget --output-document=genshin_image.jpg "$secret_url"
