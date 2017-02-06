#!/bin/bash

. ./kaldi-scripts/00_init_paths.sh  || { echo -e "\n00_init_paths.sh expected.\n"; exit; } 

#For more information about the format, please refer to Kaldi website http://kaldi.sourceforge.net/data_prep.html

#Built text file, utt2spk file and spk2utt
echo "make utt2spk and spk2utt for train dev test..."
for dir in data/train data/dev data/test
do
  pushd $dir
    cat text | cut -d' ' -f1 > utt
    cat text | cut -d'_' -f2 > spk
    paste utt spk > utt2spk
    utils/utt2spk_to_spk2utt.pl utt2spk | sort -k1 > spk2utt
    rm utt spk
  popd
done
echo -e "utt2spk and spk2utt created for train dev test.\n"

#Built wav.scp file
echo "make wav.scp for train dev test..."
for dir in data/train data/dev data/test
do
  pushd $dir
    readlink -e */*.wav > tutu1 
    cat tutu1 | awk -F'/' '{print $NF}' | sed 's/.wav//g' > tutu2 # get the final field as the recording name, remove .wav
    paste tutu2 tutu1 > wav.scp
    rm tutu2 tutu1
  popd
done
echo -e "wav.scp created for train dev test.\n"