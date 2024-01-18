# -*- coding: utf-8 -*-

import argparse
import subprocess
import json
import platform

def install_dependencies():
    # Install yt-dlp
    subprocess.run(["pip", "install", "-U", "yt-dlp"], check=True)

    # Install VLC (assuming a Debian-based system)
    if platform.system() == 'Linux':
        subprocess.run(["sudo", "apt", "install", "-y", "vlc"], check=True)

def get_video_title(video_url):
    # Create a yt_dlp YoutubeDL object
    import yt_dlp
    ydl = yt_dlp.YoutubeDL()

    try:
        # Extract information about the video (including title)
        info_dict = ydl.extract_info(video_url, download=False)

        # Return the title
        return info_dict.get('title', 'video_title')

    except yt_dlp.utils.DownloadError as e:
        # Handle errors if the command fails
        print("Error:", e)
        return 'video_title'

def clear_terminal():
    # Clear terminal screen based on the operating system
    if platform.system() == 'Windows':
        subprocess.run("cls", shell=True)
    else:
        subprocess.run("clear", shell=True)

def main():
    # Install dependencies
    # install_dependencies()

    # Create ArgumentParser object
    parser = argparse.ArgumentParser(description='Download and play YouTube videos with yt-dlp and VLC.')

    # Add an argument for the YouTube video URL
    parser.add_argument('video_url', type=str, help='URL of the YouTube video to download')

    # Parse the command-line arguments
    args = parser.parse_args()

    # URL of the YouTube video
    video_url = args.video_url

    # Get the video title
    video_title = get_video_title(video_url)

    # Command to run yt-dlp in the terminal
    yt_dlp_command = ["yt-dlp", "--extract-audio", "--audio-format", "mp3", "--get-url", video_url]

    try:
        # Run the command and capture the output
        result = subprocess.run(yt_dlp_command, capture_output=True, text=True, check=True)

        # Extract the audio URL from the output
        audio_url = result.stdout.strip()

        # Command to run VLC to play the audio with the video title as the window title
        vlc_command = ["vlc", "--meta-title", video_title, audio_url]

        # Clear the terminal
        clear_terminal()

        # Run VLC to play the audio using Popen (non-blocking)
        subprocess.Popen(vlc_command)

    except subprocess.CalledProcessError as e:
        # Handle errors if the command fails
        print("Error:", e)
        print("Error Output:\n", e.stderr)

if __name__ == "__main__":
    main()
