import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimica/src/utils/music.dart';
import 'package:mimica/src/widgets/button.dart';
import 'package:mimica/src/utils/colors.dart';
import 'package:mimica/src/widgets/icon_button.dart';
import '../../controllers/game_controller.dart';

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
  late GameController _controller;
  late Timer timer;
  int waitingTime = 3;
  bool timeIsUp = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _controller = GameController(
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
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Future<void> _playWhistleSound() async {
    try {
      BackgroundMusicPlayer.playBackgroundMusic(4);
    } catch (e) {
      print('Error playing sound: $e');
    }
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
                  text: '${_controller.score}\n',
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
    List<String> wordsPassed = _controller.wordsPassed;
    List<String> wordsCorrect = _controller.wordsCorrect;

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
              fontWeight: isCorrect ? FontWeight.bold : FontWeight.normal,
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
                  ValueListenableBuilder<int>(
                    valueListenable: _controller.remainingTime,
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
                                  textStyle:
                                      TextStyle(color: ColorsApp.letters))),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 40),
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorsApp.color1,
                    ),
                    child: Center(
                      child: Text(_controller.currentWord,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.girassol(
                              fontSize: 24,
                              textStyle: TextStyle(color: ColorsApp.letters))),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        elevation: 5,
                        buttonColor: ColorsApp.color1,
                        onPressed: () {
                          BackgroundMusicPlayer.loadMusic2();
                          BackgroundMusicPlayer.playBackgroundMusic(2);
                          setState(() {
                            _controller.nextWord(true);
                          });
                        },
                        icon: Icons.check,
                        padding: 8,
                      ),
                      const SizedBox(height: 20),
                      CustomIconButton(
                        elevation: 5,
                        buttonColor: ColorsApp.color1,
                        onPressed: () {
                          BackgroundMusicPlayer.loadMusic2();
                          BackgroundMusicPlayer.playBackgroundMusic(2);
                          setState(() {
                            _controller.nextWord(false);
                          });
                        },
                        icon: Icons.autorenew_outlined,
                        padding: 8,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: _controller.isPaused == true,
            child: Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Visibility(
              visible: _controller.isPaused == true,
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
                      label: "Sair"))),
          Positioned(
              top: 10,
              right: 10,
              child: CustomIconButton(
                elevation: 5,
                buttonColor: ColorsApp.color1,
                onPressed: () {
                  BackgroundMusicPlayer.loadMusic2();
                  BackgroundMusicPlayer.playBackgroundMusic(2);
                  setState(() {
                    _controller.pauseTimer();
                  });
                },
                icon: _controller.isPaused ? Icons.play_arrow : Icons.pause,
                padding: 0,
              )),
          Visibility(
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
                                textStyle:
                                    TextStyle(color: ColorsApp.letters))),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* */
