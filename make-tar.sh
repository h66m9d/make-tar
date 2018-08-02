read -p "Path name: " -e archivename
		archivenamenonespace=`echo $archivename | tr ' ' '_'`
		mv "$archivename" "$archivenamenonespace"
		tar -czvf $archivenamenonespace.tar.gz $archivenamenonespace/* --remove-files
		rm -rf $archivenamenonespace
