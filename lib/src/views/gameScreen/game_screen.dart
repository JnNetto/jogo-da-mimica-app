import 'package:flutter/material.dart';
import '../../controllers/game_controller.dart';

class GameScreen extends StatefulWidget {
  final String category;
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
      category: widget.category,
      initialTime: widget.timeInSeconds,
      onTimeUp: _showResults,
    );
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fim do Tempo!'),
          content: Text('Palavras Acertadas: ${_controller.score}\n'
              'Palavras Passadas: ${_controller.wordsPassed.join(', ')}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
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
      appBar: AppBar(
        title: Text('Jogo de Mímica'),
        actions: [
          IconButton(
            icon: Icon(_controller.isPaused ? Icons.play_arrow : Icons.pause),
            onPressed: () {
              setState(() {
                _controller.pauseTimer();
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _controller.remainingTime,
              builder: (context, value, child) {
                return Text(
                  'Tempo Restante: $value',
                  style: TextStyle(fontSize: 24),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              _controller.currentWord,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.nextWord(true);
                });
              },
              child: Text('Acertou'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.nextWord(false);
                });
              },
              child: Text('Passar'),
            ),
          ],
        ),
      ),
    );
  }
}
