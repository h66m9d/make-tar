
cat > ~/.config/deluge/tartorrent.sh <<EOL
#!/bin/bash
torrentid=\$1
torrentname=\$2
torrentnameunderline=\`echo \$torrentname | tr ' ' '_'\`
torrentpath=\$3
# recheck and remove
echo \$(date +"%Y-%m-%d %H:%M:%S") -- \[\$torrentname\] recheck started. >> \$torrentpath/debug.txt
deluge-console recheck \$torrentid && echo \$(date +"%Y-%m-%d %H:%M:%S") -- \[\$torrentname\] recheck completed. >> \$torrentpath/debug.txt
deluge-console rm \$torrentid && echo \$(date +"%Y-%m-%d %H:%M:%S") -- \[\$torrentname\] removed from deluge. >> \$torrentpath/debug.txt
# Go to torrent path
cd \$torrentpath
# make tarbal.gz package
tar -czvf .\$torrentnameunderline.tar.gz "\$torrentname" && echo \$(date +"%Y-%m-%d %H:%M:%S") -- \[\$torrentname\] packaging completed. >> \$torrentpath/debug.txt
rm -r "\$torrentname"
rm "\$torrentname"
echo \$(date +"%Y-%m-%d %H:%M:%S") -- \[\$torrentname\] removing cached files completed. >> \$torrentpath/debug.txt
# Rename to original name
mv .\$torrentnameunderline.tar.gz "\$torrentname.tar.gz"
echo \$(date +"%Y-%m-%d %H:%M:%S") -- \[\$torrentname\] package ready to download. >> \$torrentpath/debug.txt
EOL

chmod 755 ~/.config/deluge/tartorrent.sh

cat > ~/.config/deluge/execute.conf <<EOL
{
  "file": 1, 
  "format": 1
}{
  "commands": [
    [
      "1", 
      "complete", 
      "~/.config/deluge/tartorrent.sh"
    ]
  ]
}
EOL
