import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/game_controller.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/music.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/icon_button.dart';

class GameScreen extends StatefulWidget {
  final List<String> category;
  final int timeInSeconds;

  const GameScreen(
      {super.key, required this.category, required this.timeInSeconds});

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameController controller;
  late Timer timer;
  int waitingTime = 3;
  bool timeIsUp = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    controller = GameController(
      categorys: widget.category,
      initialTime: widget.timeInSeconds,
      onTimeUp: _showResults,
    );
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        waitingTime--;
        BackgroundMusicPlayer.loadMusic3();
        _playTickSound();
      });
      if (waitingTime == 0) {
        BackgroundMusicPlayer.loadMusic4();
        _playWhistleSound();
        setState(() {
          timeIsUp = true;
          timer.cancel();
        });
      }
    });
  }

  Future<void> _playTickSound() async {
    try {
      BackgroundMusicPlayer.playBackgroundMusic(3);
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> _playWhistleSound() async {
    try {
      BackgroundMusicPlayer.playBackgroundMusic(4);
      // ignore: empty_catches
    } catch (e) {}
  }

  void _showResults() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsApp.color2,
          title: Center(
            child: Text('Fim do Tempo!',
                style: GoogleFonts.girassol(
                    fontSize: 24,
                    textStyle: TextStyle(color: ColorsApp.letters))),
          ),
          content: SingleChildScrollView(
              child: RichText(
            text: TextSpan(
              style: GoogleFonts.girassol(
                fontSize: 24,
                textStyle: TextStyle(color: ColorsApp.letters),
              ),
              children: [
                const TextSpan(
                  text: 'Palavras Acertadas: ',
                ),
                TextSpan(
                  text: '${controller.score}\n',
                  style: GoogleFonts.girassol(
                    fontSize: 20,
                    textStyle: TextStyle(color: ColorsApp.letters),
                  ),
                ),
                const TextSpan(
                  text: 'Palavras Passadas: ',
                ),
                TextSpan(
                  children: _getWordSpans(),
                  style: GoogleFonts.girassol(
                    fontSize: 20,
                    textStyle: TextStyle(color: ColorsApp.letters),
                  ),
                ),
              ],
            ),
          )),
          actions: [
            Button(
                elevation: 10,
                buttonColor: ColorsApp.color3,
                onPressed: () {
                  BackgroundMusicPlayer.playBackgroundMusic(1);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                label: "Voltar")
          ],
        );
      },
    );
  }

  List<TextSpan> _getWordSpans() {
    List<String> wordsPassed = controller.wordsPassed;
    List<String> wordsCorrect = controller.wordsCorrect;

    List<TextSpan> spans = [];

    for (int i = 0; i < wordsPassed.length; i++) {
      String word = wordsPassed[i];
      bool isCorrect = wordsCorrect.contains(word);
      spans.add(
        TextSpan(
          text: word,
          style: GoogleFonts.girassol(
            fontSize: 20,
            textStyle: TextStyle(
              color: ColorsApp.letters,
              fontWeight: isCorrect ? FontWeight.w900 : FontWeight.normal,
            ),
          ),
        ),
      );

      if (i < wordsPassed.length - 1) {
        spans.add(
          TextSpan(
            text: ' - ',
            style: GoogleFonts.girassol(
              fontSize: 20,
              textStyle: TextStyle(color: ColorsApp.letters),
            ),
          ),
        );
      }
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: ColorsApp.background,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  timerScreen(controller),
                  const SizedBox(width: 40),
                  wordScreen(controller),
                  const SizedBox(width: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      rightButton(controller),
                      const SizedBox(height: 20),
                      shiftButton(controller),
                    ],
                  )
                ],
              ),
            ),
          ),
          blurryScreen(),
          backButton(),
          pauseButton(),
          intermidateTimeScreen()
        ],
      ),
    );
  }

  Widget timerScreen(GameController controller) {
    return ValueListenableBuilder<int>(
      valueListenable: controller.remainingTime,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorsApp.color1,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('$value',
                style: GoogleFonts.girassol(
                    fontSize: 24,
                    textStyle: TextStyle(color: ColorsApp.letters))),
          ),
        );
      },
    );
  }

  Widget wordScreen(GameController controller) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorsApp.color1,
      ),
      child: Center(
        child: Text(controller.currentWord,
            textAlign: TextAlign.center,
            style: GoogleFonts.girassol(
                fontSize: 24, textStyle: TextStyle(color: ColorsApp.letters))),
      ),
    );
  }

  Widget rightButton(GameController controller) {
    return CustomIconButton(
      elevation: 5,
      buttonColor: ColorsApp.color1,
      onPressed: () {
        BackgroundMusicPlayer.loadMusic2();
        BackgroundMusicPlayer.playBackgroundMusic(2);
        setState(() {
          controller.nextWord(true);
        });
      },
      icon: Icons.check,
      padding: 8,
    );
  }

  Widget shiftButton(GameController controller) {
    return CustomIconButton(
      elevation: 5,
      buttonColor: ColorsApp.color1,
      onPressed: () {
        BackgroundMusicPlayer.loadMusic2();
        BackgroundMusicPlayer.playBackgroundMusic(2);
        setState(() {
          controller.nextWord(false);
        });
      },
      icon: Icons.autorenew_outlined,
      padding: 8,
    );
  }

  Widget blurryScreen() {
    return Visibility(
      visible: controller.isPaused == true,
      child: Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget backButton() {
    return Visibility(
        visible: controller.isPaused == true,
        child: Center(
            child: Button(
                elevation: 10,
                buttonColor: ColorsApp.color1,
                onPressed: () {
                  BackgroundMusicPlayer.loadMusic2();
                  BackgroundMusicPlayer.playBackgroundMusic(2);
                  BackgroundMusicPlayer.playBackgroundMusic(1);
                  Navigator.pop(context);
                },
                label: "Sair")));
  }

  Widget pauseButton() {
    return Positioned(
        top: 10,
        right: 10,
        child: CustomIconButton(
          elevation: 5,
          buttonColor: ColorsApp.color1,
          onPressed: () {
            BackgroundMusicPlayer.loadMusic2();
            BackgroundMusicPlayer.playBackgroundMusic(2);
            setState(() {
              controller.pauseTimer();
            });
          },
          icon: controller.isPaused ? Icons.play_arrow : Icons.pause,
          padding: 0,
        ));
  }

  Widget intermidateTimeScreen() {
    return Visibility(
      visible: timeIsUp == false,
      child: Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text('$waitingTime',
                      style: GoogleFonts.girassol(
                          fontSize: 24,
                          textStyle: TextStyle(color: ColorsApp.letters))),
                ),
              )),
        ),
      ),
    );
  }
}

/* */
