#FROM restreamio/gstreamer:aarch64-latest-prod
#FROM bittles999/gstreamer-ubuntu
FROM bittles999/hassio-gstreamer:ubuntu
COPY app/ /app
RUN chmod a+x /app/*

CMD         ["/app/init.sh"]
WORKDIR     /app
