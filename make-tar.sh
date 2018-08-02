read -p "Path name" -e -i 2 todo
		archivenamenonespace=`echo $archivename | tr ' ' '_'`
		tar -czvf $archivenamenonespace.tar.gz $archivenamenonespace/* --remove-files
		rm -rf $archivenamenonespace
