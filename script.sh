dir="sampleImages/"
for OUTPUT in $(ls $dir)
do
	python textReader.py $dir$OUTPUT > ${OUTPUT%.*}.txt
done
