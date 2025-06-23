# Dual RTMP Streamer (YouTube + Facebook)

This script allows you to stream a video source (such as another live stream) to **YouTube and Facebook simultaneously** using `ffmpeg`.

## ✅ Features

- Streams to **YouTube Live** and **Facebook Live** at the same time
- Supports adding a **logo overlay**
- Uses `yt-dlp` to extract streamable video URLs
- Outputs in 1080p with customizable bitrate

## 📦 Requirements

- [ffmpeg](https://ffmpeg.org/download.html)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)

Install them (Ubuntu example):

```bash
sudo apt update
sudo apt install ffmpeg python3-pip -y
pip install -U yt-dlp
```

## ⚙️ Configuration

Edit the top of the `dual_stream.sh` script:

```bash
YOUTUBE_STREAM_KEY="your_youtube_stream_key"
FB_STREAM_KEY="your_facebook_stream_key"
LOGO_PATH="Logo.png"
```

- You can get your stream keys from:
  - [YouTube Live Dashboard](https://www.youtube.com/live_dashboard)
  - [Facebook Live Producer](https://www.facebook.com/live/producer)
- Optional: Enable **Persistent stream key** in Facebook settings if you want to reuse it.

## 🚀 Usage

Make the script executable and run it:

```bash
chmod +x dual_stream.sh
./dual_stream.sh
```

The script will:
1. Check if the logo file exists
2. Use `yt-dlp` to extract the stream URL from `YOUTUBE_URL`
3. Start streaming the input to both platforms with your overlay logo

## 🖼️ Example Overlay

Make sure `Logo.png` exists in the same directory. You can customize position or size in the `ffmpeg` filter section of the script.

## 📄 License

MIT
