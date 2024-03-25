#!/bin/bash

wget -O genshin.zip 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'
unzip genshin.zip
unzip genshin_character.zip

declare -A weapon_count

current_dir=$(pwd)
character_dir="$current_dir/genshin_character"
csv_file="$current_dir/list_character.csv"


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


weapon_kinds=(Bow Polearm Claymore Sword Catalyst)


for weapon_kind in "${weapon_kinds[@]}"; do
    weapon_count=$(awk -F',' '/'"$weapon_kind"'/ { ++weapon_count } END { print weapon_count }' "$csv_file")
    echo "$weapon_kind : $weapon_count"
done


rm genshin.zip
rm genshin_character.zip
rm list_character.csv
