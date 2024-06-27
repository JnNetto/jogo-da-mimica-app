import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimica/src/utils/colors.dart';
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
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ColorsApp.color3),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                shadowColor: MaterialStateProperty.all(ColorsApp.color1),
                elevation: MaterialStateProperty.all(10),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Voltar',
                  style: GoogleFonts.girassol(
                      fontSize: 15,
                      textStyle: TextStyle(color: ColorsApp.letters))),
            ),
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
                  SizedBox(width: 40),
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorsApp.color1,
                    ),
                    child: Center(
                      child: Text(_controller.currentWord,
                          style: GoogleFonts.girassol(
                              fontSize: 24,
                              textStyle: TextStyle(color: ColorsApp.letters))),
                    ),
                  ),
                  SizedBox(width: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorsApp.color1),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          shadowColor:
                              MaterialStateProperty.all(ColorsApp.color4),
                          elevation: MaterialStateProperty.all(10),
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.nextWord(true);
                          });
                        },
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorsApp.color1),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          shadowColor:
                              MaterialStateProperty.all(ColorsApp.color4),
                          elevation: MaterialStateProperty.all(10),
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.nextWord(false);
                          });
                        },
                        icon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.autorenew_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorsApp.color1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      shadowColor: MaterialStateProperty.all(ColorsApp.color4),
                      elevation: MaterialStateProperty.all(8),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Sair",
                          style: GoogleFonts.girassol(
                              fontSize: 24,
                              textStyle: TextStyle(color: ColorsApp.letters))),
                    )),
              )),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ColorsApp.color1),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                shadowColor: MaterialStateProperty.all(ColorsApp.color4),
                elevation: MaterialStateProperty.all(10),
              ),
              icon: Icon(
                _controller.isPaused ? Icons.play_arrow : Icons.pause,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _controller.pauseTimer();
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
