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

  GameScreen({required this.category, required this.timeInSeconds});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GameController(
      categorys: widget.category,
      initialTime: widget.timeInSeconds,
      onTimeUp: _showResults,
    );
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
            child: Text(
                'Palavras Acertadas: ${_controller.score}\n'
                'Palavras Passadas: ${_controller.wordsPassed.join(', ')}',
                style: GoogleFonts.girassol(
                    fontSize: 24,
                    textStyle: TextStyle(color: ColorsApp.letters))),
          ),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                            _controller.nextWord(false);
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
              ))
        ],
      ),
    );
  }
}
