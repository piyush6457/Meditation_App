import 'package:flutter/material.dart';
import 'package:meditation_app/pages/songboard.dart';
import '../widgets/meditation_card.dart';
import '../utils/assets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // App bar section
              _buildHeader(context),
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "How are you feeling today? Let's tailor the perfect experience for you.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              // Grid of meditation categories
              Expanded(child: _buildMeditationGrid(context)),
            ],
          ),
        ),
      ),
    );
  }

  // Header section with back button and welcome message
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.deepPurple,
          ),
          onTap: () => Navigator.pop(context),
        ),
        const Text(
          "Welcome Back, Buddy!",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }

  // Gridview of meditation cards
  Widget _buildMeditationGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 30,
      children: [
        _buildMeditationCard(context, kMeditateTitle, kMeditateSubtitle,
            kMeditateImageSource, kMeditateMusicSource),
        _buildMeditationCard(context, kRelaxTitle, kRelaxSubtitle,
            kRelaxImageSource, kRelaxMusicSource),
        _buildMeditationCard(context, kBrainTitle, kBrainSubtitle,
            kBrainImageSource, kBrainMusicSource),
        _buildMeditationCard(context, kStudyTitle, kStudySubtitle,
            kStudyImageSource, kStudyMusicSource),
        _buildMeditationCard(context, kSleepTitle, kSleepSubtitle,
            kSleepImageSource, kSleepMusicSource),
        _buildMeditationCard(context, kFocusTitle, kFocusSubtitle,
            kFocusImageSource, kFocusMusicSource),
      ],
    );
  }

  // Reusable method for creating each meditation card
  Widget _buildMeditationCard(BuildContext context, String title,
      String subtitle, String image, String music) {
    return MeditationCard(
      title: title,
      description: subtitle,
      image: image,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongBoard(
              musicName: title,
              imageSource: image,
              musicSource: music,
            ),
          ),
        );
      },
    );
  }
}
