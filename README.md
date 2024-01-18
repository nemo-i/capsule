# Capsule

Capsule is a simple and elegant dock GUI for Windows that allows you to listen to YouTube videos as podcasts without any video, using VLC as the media player. You can also download the videos or audio files with a single click, thanks to the integration with yt-dlp and ffmpeg. Capsule is built with Flutter and communicates with the external tools through processes.

## Features

- Listen to YouTube videos as podcasts without any video
- Download YouTube videos or audio files in various formats and quality
- Use VLC as the default media player
- Customize the dock appearance and settings
- Manage your downloads and playlists

## Installation

To use Capsule, you need to have the following tools installed on your machine:

- Python 3.9 or higher
- yt-dlp
- ffmpeg
- VLC

You also need to add these tools to your PATH environment variable, so that Capsule can find and execute them.

To install Capsule, you can clone this repository or download the zip file and extract it to your preferred location. Then, open a terminal and navigate to the Capsule folder. Run the following command to install the required Python packages:

```bash
pip install -r requirements.txt
```
# Usage
To run Capsule, you can double-click on the `capsule.exe` file or run it from the terminal:

You will see the dock window of Capsule, where you can enter a YouTube URL or a search query in the input box and press Enter. Capsule will fetch the video information and display it in the list below. You can select a video and click on the Play button to listen to it as a podcast, or click on the Download button to save it to your local folder. You can also right-click on a video to access more options, such as changing the format and quality, opening the video page, or adding the video to a playlist.

You can access the settings menu by clicking on the gear icon in the top right corner. There, you can customize the dock appearance, the download folder, the default format and quality, and other preferences.

# Screenshots
Here are some screenshots of Capsule in action:


https://github.com/nemo-i/capsule/assets/133984357/fdd479bb-eb49-4fe2-9a66-66e0127621ba


!Capsule dock window
!Capsule settings menu
!Capsule download options

# Contributing
Capsule is an open-source project and welcomes contributions from anyone who is interested. If you want to contribute, you can fork this repository and make your changes. Then, you can create a pull request and submit it for review. Please follow the code style and conventions of this project and write clear and concise commit messages.

# License
Capsule is licensed under the MIT License. See the `LICENSE` file for more details.

