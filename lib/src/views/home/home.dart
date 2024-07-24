import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimica_att/authentication.dart';
import '../../utils/colors.dart';
import '../../utils/music.dart';
import '../../widgets/button.dart';
import '../categorys/categorys.dart';
import '../instructions/instructions.dart';
import '../options/options.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialsign(context);
    });
    BackgroundMusicPlayer.loadMusic1();
    BackgroundMusicPlayer.playBackgroundMusic(1);
    super.initState();
  }

  void initialsign(BuildContext context) async {
    Authentication.user = await Authentication.signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    double? elevation = 10;

    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: ColorsApp.background,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  title(),
                  const SizedBox(height: 20),
                  playButton(context, elevation),
                  const SizedBox(height: 20),
                  instructionsButton(context, constraints, elevation),
                  const SizedBox(height: 20),
                  optionsButton(context, constraints, elevation),
                ],
              ),
            ),
            creator(),
            version()
          ],
        ),
      );
    }));
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

  Widget optionsButton(
      BuildContext context, BoxConstraints constraints, double? elevation) {
    return Button(
        elevation: elevation,
        buttonColor: ColorsApp.color1,
        onPressed: () {
          BackgroundMusicPlayer.loadMusic2();
          BackgroundMusicPlayer.playBackgroundMusic(2);
          showDialog(
            context: context,
            builder: (BuildContext context) => Options(constraints),
          );
        },
        label: "Opções");
  }

  Widget instructionsButton(
      BuildContext context, BoxConstraints constraints, double elevation) {
    return Button(
        elevation: elevation,
        buttonColor: ColorsApp.color1,
        onPressed: () {
          BackgroundMusicPlayer.loadMusic2();
          BackgroundMusicPlayer.playBackgroundMusic(2);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Instructions(constraints)),
          );
        },
        label: "Instruções");
  }

  Widget creator() {
    return Positioned(
        bottom: 10,
        left: 10,
        child: Text("by: JnNetto",
            style: GoogleFonts.girassol(
                fontSize: 20, textStyle: TextStyle(color: ColorsApp.letters))));
  }

  version() {
    return Positioned(
        bottom: 10,
        right: 10,
        child: Text("Versão: 1.0",
            style: GoogleFonts.girassol(
                fontSize: 20, textStyle: TextStyle(color: ColorsApp.letters))));
  }
}
