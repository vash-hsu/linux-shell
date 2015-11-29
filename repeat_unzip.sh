while [ 1 ]
do
  candidate=`find ./ -name "*.zip"`
  for i in $candidate
  do
    unzip $i
	rm $i
  done
  left=`find ./ -name "*.zip" | wc -l`
  if [ $left -eq 0 ]
  then
    break
  fi
done
