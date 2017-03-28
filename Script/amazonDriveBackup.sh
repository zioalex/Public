#!/bin/bash
# Run it in the WORKING DIR
# Strip the added img with
# dd if=file.png bs=2035 skip=1 of=test.tar.bz2.gpg
# decrypt it with
# gpg -d test.tar.bz2.gpg  |tar jtvf -
rclonedest=AmazonDrive
sample_img=~/bin/index.png # 2035 bytes
SPLIT_SIZE="1G"
backuptmpdir="backuptmp.$$"

[ ! -d $backuptmpdir ] && mkdir $backuptmpdir

source=$*

splitfile() {
	split -b $SPLIT_SIZE -d ${1} ${1}_
}

prepend() {
    cat $sample_img ${1} > ${1}.png && rm ${1}
}

for i in $source
do 
    echo "Start process of $i"
    date
    cleansource=$(echo $i | sed 's/\///g')
    local_archive_info="${cleansource}_archive_info"
    [ ! -d $local_archive_info ] && mkdir $local_archive_info
    echo "Create big archive"
    tar --index-file=$local_archive_info/${cleansource}.tar.list jvcf - ${cleansource} | gpg -q -e  --output $backuptmpdir/${cleansource}.tar.bz2.gpg
    # Check available space and exit if not > tar_size * 2
    echo "Created Archive $backuptmpdir/${cleansource}.tar.bz2.gpg"
    cd $backuptmpdir
    # Split gpg file
    echo "Splitting"
    splitfile "${cleansource}.tar.bz2.gpg" && rm -f ${cleansource}.tar.bz2.gpg
    # create splitted file with the prepend image
    echo "Prepending Image"
    for part in ${cleansource}.tar.bz2.gpg_*
    do
    	prepend ${part}
	md5sum ${part}.png > ${part}.png.md5
    done
#    cat $sample_img ${cleansource}.tar.bz2.gpg > ${cleansource}.tar.bz2.gpg.png && rm ${cleansource}.tar.bz2.gpg
    cd -
    cp $backuptmpdir/*.png.md5 $local_archive_info/
    ls -al $backuptmpdir/ > $local_archive_info/info.txt
    echo "Starting rcloning of $backuptmpdir - $i"
    rclone --retries 10 --drive-chunk-size=1024k --stats=30m copy $backuptmpdir/ $rclonedest:Bilder/ && rm -f $backuptmpdir/${cleansource}.tar.bz2.gpg_*.png
    echo "End process of $i"
done

# Clean up
rmdir $backuptmpdir
