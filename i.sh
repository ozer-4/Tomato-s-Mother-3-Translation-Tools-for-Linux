export WINEDEBUG=fixme-all
echo ---------------------------------------------------------
echo Converting non-script text files to data files
echo ---------------------------------------------------------
echo
mv -f custom_text.txt custom_text_TMP.txt
mv -f enemynames_short.txt enemynames_short_TMP.txt
mv -f castroll_names.txt castroll_names_TMP.txt
mv -f special_itemdescriptions.txt special_itemdescriptions_TMP.txt
python prepare_special_text.py custom_text_TMP.txt custom_text.txt
python prepare_special_text.py enemynames_short_TMP.txt enemynames_short.txt
python prepare_special_text.py castroll_names_TMP.txt castroll_names.txt
python prepare_special_text.py custom_text_TMP.txt special_itemdescriptions.txt
wine textconv
./fix_custom_text text_custom_text.bin
./rearrange_font font_mainfont.bin font_smallfont.bin font_castroll.bin font_mainfont_rearranged.bin font_castroll_rearranged.bin font_mainfont_used.bin font_smallfont_used.bin
mv -f custom_text_TMP.txt custom_text.txt
mv -f enemynames_short_TMP.txt enemynames_short.txt
mv -f castroll_names_TMP.txt castroll_names.txt
mv -f special_itemdescriptions_TMP.txt special_itemdescriptions.txt
echo
echo
echo ---------------------------------------------------------
echo "Copying base ROM (mother3.gba) to new test ROM (test.gba)"
echo ---------------------------------------------------------
echo
cp mother3j.gba test.gba
echo Done
echo
echo
echo ---------------------------------------------------------
echo "Freeing enemy graphics' space"
echo ---------------------------------------------------------
echo
./FreeSpace test.gba -v
echo
echo
echo ---------------------------------------------------------
echo Converting audio .snd files to data files
echo ---------------------------------------------------------
echo
wine soundconv readysetgo.snd lookoverthere_eng.snd
echo
echo
echo ---------------------------------------------------------
echo "Creating pre-welded cast of characters & sleep mode text"
echo ---------------------------------------------------------
echo
wine m3preweld
echo
echo
echo ---------------------------------------------------------
echo "Checking overlap of the files that will be used"
echo ---------------------------------------------------------
echo
python check_overlap.py m3hack.asm
echo
echo
echo ---------------------------------------------------------
echo "Compiling .asm files and inserting all new data files"
echo ---------------------------------------------------------
echo
wine xkas test.gba m3hack.asm
echo
echo
echo COMPLETE!
echo
