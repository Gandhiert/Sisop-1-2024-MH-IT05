wget -O genshin.zip 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'
unzip genshin.zip
unzip genshin_character.zip

declare -A weapon_count

current_dir=$(pwd)
character_dir="$current_dir/genshin_character"
csv_file="$current_dir/list_character.csv"

for file in "$character_dir"/*.jpg; do
    decoded_name=$(basename "$file" | xxd -r -p)

    region=$(awk -F',' -v name="$decoded_name" '$1 == name {print $2}' "$csv_file")
    elemen=$(awk -F',' -v name="$decoded_name" '$1 == name {print $3}' "$csv_file")
    weapon=$(awk -F',' -v name="$decoded_name" '$1 == name {print $4}' "$csv_file")
    mkdir -p "$character_dir/$region"
    
    if [ -f "$file" ]; then
        mv "$file" "$character_dir/$region/$region-$decoded_name-$elemen-$weapon.jpg"
    else
        echo "File not found: $file"
    fi
done

weapon_types=(Catalyst Bow Polearm Sword Claymore)

for weapon_type in "${weapon_types[@]}"; do
  count=$(awk -F',' '/'"$weapon_type"'/ { ++count } END { print count }' "$csv_file")
  echo "$weapon_type : $count"
done

rm genshin.zip
rm genshin_character.zip
rm list_character.csv
