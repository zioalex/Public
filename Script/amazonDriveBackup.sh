#!/bin/bash
# Strip the added img with
# dd if=file.png bs=2035 skip=1 of=test.tar.bz2.gpg
# decrypt it with
# gpg -d test.tar.bz2.gpg  |tar jtvf -
rclonedest=AmazonDrive
sample_img=~/bin/index.png # 2035 bytes

source=$*

function split() {
	split 
}

function prepend() {
    cat $sample_img ${cleansource}.tar.bz2.gpg > ${cleansource}.tar.bz2.gpg.png && rm ${cleansource}.tar.bz2.gpg
}

for i in $source
do 
    echo "Start process of $i"
    date
    cleansource=$(echo $i | sed 's/\///g')
    tar jcf - ${cleansource} | gpg -q -e  > ${cleansource}.tar.bz2.gpg
    # Split gpg file
    echo "Created Archive ${cleansource}.tar.bz2.gpg"
    # create splitted file with the prepend image
    cat $sample_img ${cleansource}.tar.bz2.gpg > ${cleansource}.tar.bz2.gpg.png && rm ${cleansource}.tar.bz2.gpg
    rclone --drive-chunk-size=1024k --stats=30m copy ${cleansource}.tar.bz2.gpg.png $rclonedest:Bilder/ && rm -f ${cleansource}.tar.bz2.gpg.png 
    echo "End process of $i"
done

