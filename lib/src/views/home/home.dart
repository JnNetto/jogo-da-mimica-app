import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimica/src/utils/music.dart';
import 'package:mimica/src/widgets/button.dart';
import '../../utils/colors.dart';
import '../categorys/categorys.dart';
import '../options/options.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BackgroundMusicPlayer.playBackgroundMusic(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? elevation = 10;

    return Scaffold(
      body: Container(
        color: ColorsApp.background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title(),
              const SizedBox(height: 20),
              playButton(context, elevation),
              const SizedBox(height: 20),
              optionsButton(context, elevation)
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Text("Mímica",
        style: GoogleFonts.girassol(
            fontSize: 60, textStyle: TextStyle(color: ColorsApp.letters)));
  }

  Widget playButton(BuildContext context, double? elevation) {
    return Button(
        elevation: elevation,
        buttonColor: ColorsApp.color1,
        onPressed: () {
          BackgroundMusicPlayer.loadMusic2();
          BackgroundMusicPlayer.playBackgroundMusic(2);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Category()),
          );
        },
        label: "Jogar");
  }

  Widget optionsButton(BuildContext context, double? elevation) {
    return Button(
        elevation: elevation,
        buttonColor: ColorsApp.color1,
        onPressed: () {
          BackgroundMusicPlayer.loadMusic2();
          BackgroundMusicPlayer.playBackgroundMusic(2);

          showDialog(
            context: context,
            builder: (BuildContext context) => const Options(),
          );
        },
        label: "Opções");
  }
}
