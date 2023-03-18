#!/bin/sh
set -eu

rm -f gstream-dr-lo.log

tail --pid $$ -F gstream-dr-lo.log &

gst-launch-1.0 rtspsrc protocols=tcp \
location='rtsp://driveway:kPaWrZG8A9@192.168.21.61:8654/video2_unicast' \
latency=100 buffer-mode=3 connection-speed=1500 \
name=t t. ! queue ! \
capsfilter caps="application/x-rtp,media=video,height=640,width=360" ! \
queue ! rtph264depay ! h264parse ! queue ! \
rtspclientsink protocols=tcp latency=0 \
location=rtsp://192.168.21.41:8554/driveway_lo \
name=pay t. ! queue ! \
capsfilter caps="application/x-rtp,media=audio,clock-rate=8000,encoding-name=L16" ! \
rtpL16depay ! queue ! audioconvert ! queue ! \
volume volume=1.5 ! audioresample ! \
opusenc audio-type=2051 bandwidth=-1000 \
bitrate=64000 ! queue ! \
pay. > gstream-dr-lo.log
