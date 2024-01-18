import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_cast_dock/uitls/is_youtube_link.dart';
import 'package:simple_cast_dock/uitls/run_python_script.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

const size = Size(358, 55);
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: size,
    alwaysOnTop: true,
    minimumSize: size,
    backgroundColor: Colors.transparent,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAlignment(Alignment.topCenter, animate: true);
    final postion = await windowManager.getPosition();
    await windowManager.setAsFrameless();
    await windowManager.setHasShadow(false);
    await windowManager.setPosition(Offset(
      postion.dx,
      -50,
    ));
    await windowManager.setOpacity(1);
  });
  _createCapsuleFolder();
  runApp(const Capusle());
}

class Capusle extends StatefulWidget {
  const Capusle({super.key});

  @override
  State<Capusle> createState() => _CapusleState();
}

class _CapusleState extends State<Capusle> {
  final PageController _controller = PageController();
  final TextEditingController _editingController = TextEditingController();
  Set<int> values = {720};
// 358
//55
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        await windowManager.startDragging();
        await windowManager.setSize(size);
      },
      child: MouseRegion(
        onEnter: (eveant) async {
          final postion = await windowManager.getPosition();
          await windowManager.setPosition(Offset(
            postion.dx,
            0,
          ));
        },
        onExit: (event) async {
          final postion = await windowManager.getPosition();
          await windowManager.setPosition(Offset(
            postion.dx,
            -50,
          ));
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Row(
                children: [
                  iconButton(
                      () => _controller.previousPage(
                          duration: duration, curve: curve),
                      Icons.arrow_back_ios),
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            lottieButton(
                              'earth',
                              _launchUrl,
                            ),
                            Expanded(child: textArea(_editingController)),
                            actionIcon('link_3', () => _paste, size: 19),
                            // lottieButton(
                            //   'link',
                            //   _paste,
                            // ),
                            actionIcon('play-button', () {
                              _listenToAudio(
                                _editingController.text,
                              );
                            }, size: 20),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            lottieButton(
                              'download',
                              _openDownloadsFolder,
                            ),
                            segmentButton(
                              onSelectionChanged: (values) {
                                setState(() {
                                  this.values = values;
                                });
                              },
                              values: values,
                            ),
                            actionIcon('music-download', () {
                              downloadQuilty(
                                values.first,
                                _editingController.text.trim(),
                              );
                            }, size: 17)
                          ],
                        ),
                      ],
                    ),
                  ),
                  iconButton(
                      () => _controller.nextPage(
                          duration: duration, curve: curve),
                      Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _paste() async {
    ClipboardData? data = await Clipboard.getData("text/plain");
    if (data != null) {
      if (data.text != null) {
        if (data.text!.isNotEmpty) {
          if (isYouTubeLink(data.text!)) {
            _editingController.value = TextEditingValue(
              text: data.text!,
            );
          }
        }
      }
    }
  }
}

Widget textArea(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 13),
    child: TextField(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        border: OutlineInputBorder(),
      ),
      controller: controller,
    ),
  );
}

Widget actionIcon(String name, Function() onTap, {double size = 30}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
          child: Image.asset(
            'assets/icons/$name.png',
            filterQuality: FilterQuality.medium,
            width: size,
            height: size,
          ),
        ),
      ),
    ),
  );
}

Widget lottieButton(String fileName, Function() onTap, {double size = 37}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: LottieBuilder.asset(
        'assets/icons/$fileName.json',
        height: size,
        width: size,
      ),
    ),
  );
}

Widget iconButton(Function() onPressed, IconData icon) {
  return InkWell(
    onTap: onPressed,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Icon(
        icon,
        size: 13,
      ),
    ),
  );
}

const duration = Duration(milliseconds: 210);
const curve = Curves.easeIn;
Future<void> _launchUrl() async {
  const url = "https://www.youtube.com/";
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

Future<void> _openDownloadsFolder() async {
  try {
    // Get the path to the Downloads folder
    final downloadsDir = await getDownloadsDirectory();

    // Get the path to the explorer.exe executable
    const explorerPath = 'explorer.exe';

    // Construct the command to open the file explorer
    final command = '$explorerPath ${downloadsDir?.path}\\capsule';

    // Launch the file explorer
    await Process.run(command, [], runInShell: true);
  } catch (e) {
    print('Error opening Downloads folder: $e');
  }
}

Future<void> _createCapsuleFolder() async {
  try {
    // Get the path to the Downloads folder
    final downloadsDir = await getDownloadsDirectory();

    // Create the "capsule" folder if it doesn't exist
    final capsuleDir = Directory('${downloadsDir?.path}\\capsule');

    if (!(await capsuleDir.exists())) {
      await capsuleDir.create();
      print('Capsule folder created: ${capsuleDir.path}');
    } else {
      print('Capsule folder already exists: ${capsuleDir.path}');
    }
  } catch (e) {
    print('Error creating/checking capsule folder: $e');
  }
}

void _listenToAudio(String url) async {
  log('we are here in listen audio');
  await runPythonScript(url);
}

Widget segmentButton({
  Set<int> values = const {720},
  Function(Set<int> values)? onSelectionChanged,
}) {
  return SegmentedButton(
    style: ButtonStyle(
        side: MaterialStatePropertyAll<BorderSide>(
            BorderSide(color: Colors.grey.shade400, width: .5))),
    showSelectedIcon: false,
    onSelectionChanged: onSelectionChanged,
    segments: const [
      ButtonSegment(value: 1080, label: Text('1080P')),
      ButtonSegment(value: 720, label: Text('720P')),
      ButtonSegment(
        value: 480,
        label: Text('480P'),
      ),
    ],
    selected: values,
  );
}

void downloadQuilty(int value, String url) async {
  switch (value) {
    case 1080:
      await runCommand(command(1080, url));
      break;
    case 480:
      await runCommand(command(480, url));
      break;
    default:
      await runCommand(command(720, url));
      break;
  }
}

List<String> command(int res, String url) {
  return [
    '-i',
    '-o',
    'C:/Users/tanto/Downloads/capsule/%(playlist)s/%(playlist_index)s. %(title)s.%(ext)s',
    '--write-sub',
    '--sub-lang',
    'en',
    '--playlist-items',
    '1-',
    '-f',
    'bestvideo[height<=$res]+bestaudio/best[height<=$res]',
    url,
  ];
}

Future<void> runCommand(List<String> command) async {
  final process = await Process.start(
    'yt-dlp',
    command,
  );
  process.stdout.pipe(stdout);
  process.stderr.pipe(stderr);
  // process.stdout.transform(utf8.decoder).listen((data) {
  //   print('stdout: $data');
  // });

  // process.stderr.transform(utf8.decoder).listen((data) {
  //   print('stderr: $data');
  // });

  // int exitCode = await process.exitCode;
  // print('Process exited with code $exitCode');
}
