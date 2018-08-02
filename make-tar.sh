read -p "Path name" -e -i 2 archivename
		archivenamenonespace=`echo $archivename | tr ' ' '_'`
		mv "$archivename" $archivenamenonespace
		tar -czvf $archivenamenonespace.tar.gz $archivenamenonespace/* --remove-files
		rm -rf $archivenamenonespace
