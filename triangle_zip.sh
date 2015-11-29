target=${1}
working=${2}

Usage () {
   printf "Usage  : %s TARGET_FIEL_to_ZIP PATH_TO_TEMP_FOLDER\n" $0
   printf "Example: %s treasure.txt _temp\n" $0
   printf "         where _temp will be created and lots of zip file created based on treasure.txt\n"
}

echo target is $target
echo working is $working

if [ ! $target ] || [ ! $working ]
then
  Usage
  exit
fi

if [ $target ] && [ -e $target ]
then
  echo INFO: prepare zip $target
else
  echo ERROR: invalid target file: $target
  Usage
  exit
fi

if [ ! $working ] || [ -d $working ] || [ -e $working ]
then
  echo ERROR: temp folder conflicting: $working
  Usage
  exit
else
  echo INFO: prepare use $working as working folder
fi

mkdir $working
cp $target $working
cd $working

zip _1.zip $target
sleep 1
touch $target
zip 1_.zip $target

for row in 2 3 4
do
  col=`expr $row + 1`
  i=1
  while [ $i -lt $col ]
  do
    printf "[_%s.zip]\n" $i
    if [ -e _$i.zip ]
    then
       sleep 1
       touch _$i.zip
    else
       echo zip _$i.zip *.zip
       zip _$i.zip *.zip
    fi
    if [ -e $i\_.zip ]
    then
       sleep 1
       touch $i\_.zip
    else
       echo zip $i\_.zip *.zip -x _$i.zip
       zip $i\_.zip *.zip -x _$i.zip
    fi
    i=`expr $i + 1`
  done
  printf "\n"
done

echo zip $col.zip *.zip
zip $col.zip *.zip
cp $col.zip ../
cd ../
rm -rf $working
