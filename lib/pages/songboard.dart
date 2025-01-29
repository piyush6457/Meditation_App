import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../utils/utils.dart';
import '../widgets/circle_play_button.dart';
import '../widgets/rectangle_button.dart';

class SongBoard extends StatefulWidget {
  const SongBoard({
    super.key,
    required this.musicName,
    required this.musicSource,
    required this.imageSource,
  });

  final String musicName;
  final String musicSource;
  final String imageSource;

  @override
  State<SongBoard> createState() => _SongBoardState();
}

class _SongBoardState extends State<SongBoard> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String musicName = '';
  String musicSource = '';
  String imageSource = '';

  @override
  void initState() {
    super.initState();
    updateUI(
      widget.musicName,
      widget.musicSource,
      widget.imageSource,
    );

    setAudio();

    player.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.PLAYING;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  void updateUI(
    String newMusicName,
    String newMusicSource,
    String newImageSource,
  ) {
    musicName = newMusicName;
    musicSource = newMusicSource;
    imageSource = newImageSource;
  }

// Future setAudio() async {
//   try {
//     // Using AudioSource.asset to specify the audio file path from assets
//     final source = AudioSource.asset(musicSource);

//     // Play the audio
//     await player.play(source);

//     // Set the release mode to loop
//     player.setReleaseMode(ReleaseMode.LOOP);
//   } catch (e) {
//     print("Error loading audio: $e"); // Important: Handle errors!
//   }
// }

  Future setAudio() async {
    AssetSource source = AssetSource('musics/$musicSource');
    await player.play(source);
    // repeat the music
    player.setReleaseMode(ReleaseMode.LOOP);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/$imageSource',
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  musicName,
                  style: kLargeTextStyle,
                ),
                Slider(
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  activeColor: Colors.deepPurple,
                  inactiveColor: Colors.deepPurple.withOpacity(0.5),
                  onChanged: (double value) async {
                    // Added async
                    setState(() {
                      position = Duration(
                          seconds: value.toInt()); // Update UI immediately
                    });
                    await player
                        .seek(Duration(seconds: value.toInt())); // Then seek
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CirclePlayButton(
                      isPlaying: isPlaying,
                      player: player,
                      onPressed: () {
                        if (isPlaying) {
                          player.pause();
                        } else {
                          player.resume();
                        }
                      },
                      //icon: isPlaying
                      // ? Icons.pause_circle_filled
                      // : Icons.play_circle_filled,
                      //isPlaying: null,
                    ),
                    RectangleButton(
                      onPressed: () {
                        player.stop();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Stop",
                        style: kButtonTextStyle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
