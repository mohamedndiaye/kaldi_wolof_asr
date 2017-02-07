#!/bin/bash

##
# Create and prepare the dict/ directory
# Once the script ran, dict/ directory will contain:
# lexicon.txt, nonsilence_phones, silence_phones.txt, optional_silence.txt
##

mkdir -p data/local/dict
pushd data/local/dict

##create nonsilence_phones.txt
cat ../lang/lexicon.txt | awk '{for (i=2;i<=NF;i++) print $i}' | sort -u > nonsilence_phones.txt
#cat ../lang_lengthLabel/lexicon.txt | awk '{for (i=2;i<=NF;i++) print $i}' | sort -u > nonsilence_phones.txt    #--2 phone units for 1 vowel (i.e.: vowel /a/ is represented [a] and [aL])

##create silence_phones.txt
echo "SIL" > silence_phones.txt
##extra_questions.txt
touch extra_questions.txt

rm -f lexicon.txt # if run twice, don't append to old one
##lexicon.txt
cat ../lang/lexicon.txt | sed 's/(.)//' > lexicon.txt
#cat ../lang_lengthLabel/lexicon.txt | sed 's/(.)//' > lexicon.txt   #-- vowels are length contrasted in the acoustic dictionary 

##write UNK symbol
echo -e "SIL\tSIL" >> lexicon.txt
echo -e "<UNK>\tSIL" >> lexicon.txt
echo "SIL" > optional_silence.txt
echo "<UNK>" > ../lang/oov.txt
#echo "<UNK>" > ../lang_lengthLabel/oov.txt
