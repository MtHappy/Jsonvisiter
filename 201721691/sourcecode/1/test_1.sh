files="data/*"

for filepath in $files; do
	echo $filepath
    ruby test_1.rb -f $filepath
done