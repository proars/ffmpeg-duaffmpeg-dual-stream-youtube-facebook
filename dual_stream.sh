#!/bin/bash

# ==== Stream Settings ====
YOUTUBE_STREAM_KEY="your_youtube_stream_key"
FB_STREAM_KEY="your_facebook_stream_key"

LOGO_PATH="Logo.png"
VIDEO_RESOLUTION="1920:1080"
VIDEO_BITRATE="3700k"

RTMP_YOUTUBE="rtmp://a.rtmp.youtube.com/live2/$YOUTUBE_STREAM_KEY"
RTMP_FACEBOOK="rtmp://live-api-s.facebook.com:80/rtmp/$FB_STREAM_KEY"

YOUTUBE_URL="https://www.youtube.com/"  # used as source (via yt-dlp)
# ===================================

# Check logo exists
if [ ! -f "$LOGO_PATH" ]; then
  echo "Logo not found: $LOGO_PATH"
  exit 1
fi

# Extract stream URL
echo "Getting stream link from YouTube..."
STREAM_URL=$(yt-dlp -g "$YOUTUBE_URL")

if [ -z "$STREAM_URL" ]; then
  echo "Check yt-dlp and the provided link"
  exit 1
fi

# Setup output destinations
OUTPUT="tee:\"[f=flv]$RTMP_YOUTUBE|[f=flv]$RTMP_FACEBOOK\""

echo "Streaming to YouTube and Facebook in 1080p @ $VIDEO_BITRATE..."

# Start streaming
ffmpeg -re -i "$STREAM_URL" -i "$LOGO_PATH" \
  -filter_complex "[0:v]scale=$VIDEO_RESOLUTION[fv];[fv][1:v]overlay=0:0[outv]" \
  -map "[outv]" -map 0:a \
  -c:v libx264 -preset veryfast -b:v "$VIDEO_BITRATE" \
  -c:a aac -b:a 128k \
  -f tee $OUTPUT
