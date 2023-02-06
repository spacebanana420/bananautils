#!/bin/bash
compress () {
while [[ $compression != "xz" ]] && [[ $compression != "7z" ]]
do
    echo "Choose compression archive: xz  7z"
    read compression
done

echo "Archive folder name?"
read fname
echo "Delete unarchived content afterwards (y/n)"
read deletecontent

mkdir "$fname"
cd "$fname"
mkdir png
mkdir unchanged
cd ..
for i in *
do
    case $i in
    *".png"*)
        i2=$(basename -s ".png" "$i")
        ffmpeg -i "$i" -compression_algo raw "$i2.tiff"
        mv "$i2.tiff" "$fname/png";
        if [[ $deletecontent == "y" ]]
        then
            rm "$i"
        fi
    ;;
        *".tiff"* | *".tif"* | *".bmp"* | *".gif"* | *".webp"* | *".jpg"* | *".jpeg"* | *".heic"* | *".heif"* | *".avif"*)
        if [[ $deletecontent == "y" ]]
        then
            mv "$i" "$fname/unchanged"
        else
            cp "$i" "$fname/unchanged"
        fi
    ;;
    esac
done
echo "Archiving folder"
case $compression in
xz)
    echo "XZ compression level? (0-9) (default=0)"
    read xzcomp
    if [[ $xzcomp < 0 ]]; then xzcomp=0
    elif [[ $xzcomp > 9 ]]; then xzcomp=9
    elif [[ $xzcomp == "" ]]; then xzcomp=0
    fi
    tar -cf "$fname.tar" "$fname" && xz -zv -$xzcomp --threads=0 "$fname.tar"
;;
7z)
    7z a "$fname.7z" "$fname"
;;
esac

rm -r "$fname"
echo "All is done!"
}

decompress () {
echo "Archive file name"
read arname
case $arname in
*.7z*)
    arname2=$(basename -s ".7z" $arname)
    7z e "$arname"
;;
*.xz*)
    arname2=$(basename -s ".tar.xz" $arname)
    tar -xf "$arname"
;;
*)
    echo "Unsupported archive, must be a 7zip or xz archive"
    return
;;
esac

cd "$arname2/png"
for i in *
do
    if [[ $i == *".tiff"* ]]
    then
    i2=$(basename -s ".tiff" "$i")
        ffmpeg -i "$i" "$i2.png"
        mv "$i2.png" ..
    fi
done

cd ..
cd unchanged
for i in *
do
    mv "$i" ..
done
cd ..
rm -r png unchanged

echo "All is done!"
}

echo "Image Archiver (version 2.2)"
echo "Decompressing archives created by older versions might not work properly"
echo ""; echo ""

if [[ $1 == "1" || $1 == "compress"  ]]
then
    compress
elif [[ $1 == "2" || $1 == "decompress"  ]]
then
    decompress
else
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
fi
