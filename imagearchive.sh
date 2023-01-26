#!/bin/bash
compress () {
while [[ $compression != "xz" ]] && [[ $compression != "7z" ]]
do
    echo "Compression (xz, 7z)"
    read compression
done
echo "Archive folder name?"
read fname
mkdir "$fname"
for i in *
do
    case $i in
    *".png"*)
    i2=$(basename -s ".png" "$i")
    ffmpeg -i "$i" -compression_algo raw "$i2.tiff"
    touch "${i2}.txt"
    mv "$i2.tiff" "$fname"; mv "${i2}.txt" "$fname"
    rm "$i"
    ;;
    *".tiff"* | *".tif"* | *".bmp"* | *".gif"* | *".webp"* | *".jpg"* | *".jpeg"* | *".heic"* | *".heif"* | *".avif"*)
    mv "$i" "$fname"
    ;;
    esac
done
echo "Archiving folder..."
case $compression in
xz)
    tar -cf "$fname.tar" "$fname" && xz -z --threads=0 "$fname.tar"
;;
7z)
    7z a "$fname.7z" "$fname"
;;
esac
echo "Delete unarchived folder? (y/n)"
read deleteanswer
if [[ $deleteanswer == "y" ]]
then
    rm -r "$fname"
fi
echo "All is done!"
}

decompress () {
echo "Archive name"
read arname
echo "Archive format"
read arformat
case $arformat in
*7z*)
7z e "$archive.$arformat"
;;
*gz* | *bz2* | *bz2* | *xz*)
tar -xf "$archive.$arformat"
;;
*)
echo "Unsupported archive"
return
;;
esac

cd "$arname"
for i in *
do
    if [[ $i == *".txt"* ]]
    then
        i2=$(basename -s ".txt" $i)
        if [[ -e "$i2.tiff" ]]
        then
            ffmpeg -i "$i2.tiff" "$i2.png"
            rm $i2.tiff
        elif [[ -e "$i2.bmp" ]]
        then
            ffmpeg -i "$i2.bmp" "$i2.png"
            rm $i2.bmp
        fi
    rm "$i"
    fi
done
echo "All is done!"
}

echo "Choose a task"
echo "compress / decompress (1 / 2)"
read task
if [[ $task == "compress" || $task == "1" ]]
then
    compress
elif [[ $task == "decompress" || $task == "2" ]]
then
    decompress
else
    return
fi
