# echo "Attemping to build $MAKEFILE with $SRC"
# echo "$PATH"
cp -r $src/* .

make 
mkdir $out/bin/ -p
mv mini-hello $out/bin