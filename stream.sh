#!/bin/bash
RTSP_URL=""
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
YOUTUBE_KEY=""
COMMAND="ffmpeg -rtsp_transport tcp -i ${RTSP_URL} -tune zerolatency -vcodec libx264 -t 12:00:00 -pix_fmt + -c:v copy -c:a aac -f flv ${YOUTUBE_URL}/${YOUTUBE_KEY}"

case $1 in
  start)
     $COMMAND &>/var/log/ffmpeg-log.out &
     echo $! > /var/run/stream.pid ;
     ;;
   stop)
     kill `cat /var/run/stream.pid` ;;
   *)
     echo "usage: stream.sh {start|stop}" ;;
esac
exit 0
