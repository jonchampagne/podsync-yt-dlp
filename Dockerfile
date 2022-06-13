FROM alpine:3.16
WORKDIR /app

RUN apk --no-cache add ca-certificates python3 ffmpeg tzdata
# Naievely download yt-dlp as a dropin to youtube-dl
RUN wget -O /usr/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/download/2021.12.27/yt-dlp && chmod +x /usr/bin/yt-dlp

# Download the podsync binary
RUN wget -O /app/podsync.tar.gz https://github.com/mxpv/podsync/releases/download/v2.4.2/Podsync_2.4.2_Linux_x86_64.tar.gz &&\
    tar -xvzf podsync.tar.gz podsync &&\
    rm podsync.tar.gz &&\
    chmod +x podsync

COPY youtube-dl /usr/bin/youtube-dl
RUN chmod +x /usr/bin/youtube-dl

ENTRYPOINT ["/app/podsync"]
CMD ["--no-banner"]