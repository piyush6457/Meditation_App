import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../utils/utils.dart';

class CirclePlayButton extends StatelessWidget {
  const CirclePlayButton({
    super.key,
    required this.isPlaying,
    required this.player,
    required this.onPressed, // Corrected the onPressed parameter type
  });

  final bool isPlaying;
  final AudioPlayer player;
  final VoidCallback onPressed; // Correct type for onPressed callback

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          kCircleBoxDecoration, // Assuming kCircleBoxDecoration is a predefined constant
      child: Center(
        child: IconButton(
          icon: isPlaying
              ? kPauseIcon
              : kPlayIcon, // Assuming kPauseIcon & kPlayIcon are predefined constants
          onPressed: onPressed, // Use the passed callback for onPressed
        ),
      ),
    );
  }
}
