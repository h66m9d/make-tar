tar -czvf $archivenamenonespace.tar.gz $archivenamenonespace/* --remove-files
rm -r $archivenamenonespace



read -p "Playlist(1) OR Channel(2) or SingleVideo(3)? [1/2/3]: " -e -i 2 todo
	if [[ "$todo" = '1' ]]; then
		addtoplaylisttrue="y"
		while [  $addtoplaylisttrue == "y" ]; do
			read -p "Enter Playlist URL (eg: https://www.youtube.com/watch?v=nfWlot6h_JM&list=PLmU8B4gZ41idW0H82OGG8nvlkceNPqpvq): " playlisturl
			echo $playlisturl | cut -d"=" -f3 >> /tmp/list
			read -p "Add more? [y/n] " -e -i "y" addtoplaylisttrue
		done
		videofilename="%(playlist_uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s"
		yesplaylist="--yes-playlist"
	elif [[ "$todo" = '2' ]]; then
		read -p "Enter Channel Playlists URL (eg: https://www.youtube.com/user/VEVO/playlists): " channelplaylisturl
		curl $channelplaylisturl > /tmp/page
		sed -n 's/.*href="\([^"]*\).*/\1/p' /tmp/page | grep "?list" | cut -d"=" -f2 | sort -u > /tmp/list
		videofilename="%(playlist_uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s"
		yesplaylist="--yes-playlist"
	elif [[ "$todo" = '3' ]]; then
		addtoplaylisttrue="y"
		while [  $addtoplaylisttrue == "y" ]; do
			read -p "Enter video URL (eg: https://www.youtube.com/watch?v=nfWlot6h_JM): " videourl
			echo $videourl | cut -d"=" -f2 | cut -d"&" -f1 >> /tmp/list
			videofilename='"%(uploader)s/%(title)s.%(ext)s"'
			read -p "Add more? [y/n] " -e -i "y" addtoplaylisttrue
		done
		yesplaylist=""
	else
		exit
	fi
