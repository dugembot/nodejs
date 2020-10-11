#!/bin/sh
if [[ -n $RCLONE_CONFIG && -n $RCLONE_DESTINATION ]]; then
	echo "Rclone config detected"
	echo -e "[DRIVE]\n$RCLONE_CONFIG" > rclone.conf
	echo "on-download-stop=./delete.sh" >> aria2.conf
	echo "on-download-complete=./on-complete.sh" >> aria2.conf
	chmod +x delete.sh
	chmod +x on-complete.sh
  touch aria2.session
fi

echo "rpc-secret=$ARIA2C_SECRET" >> aria2c.conf

darkhttpd /front --port 8000 &
darkhttpd /downloads --port 8080 &
aria2c --conf-path=aria2.conf
