import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mimica/src/utils/words.dart';

class GameController {
  final String category;
  final int initialTime;
  final ValueNotifier<int> remainingTime;
  int score = 0;
  String currentWord = '';
  List<String> words = [];
  List<String> wordsPassed = [];
  List<String> wordsCorrect = [];
  bool isPaused = false;

  late Timer _timer;
  final Function onTimeUp;

  GameController(
      {required this.category,
      required this.initialTime,
      required this.onTimeUp})
      : remainingTime = ValueNotifier<int>(initialTime) {
    words = _getWordsForCategory(category);
    currentWord = _getRandomWord();
    _startTimer();
  }

  List<String> _getWordsForCategory(String category) {
    switch (category) {
      case 'Verbos':
        return ListWords.verbos;
      case 'Filmes':
        return ['Inception', 'Titanic', 'Avatar', 'Matrix'];
      case 'Objetos':
        return ['Mesa', 'Cadeira', 'Computador', 'Lâmpada'];
      default:
        return [];
    }
  }

  String _getRandomWord() {
    if (words.isEmpty) return '';
    return (words..shuffle()).first;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0 && !isPaused) {
        remainingTime.value--;
      } else if (remainingTime.value == 0) {
        _timer.cancel();
        onTimeUp();
      }
    });
  }

  void pauseTimer() {
    isPaused = !isPaused;
  }

  void nextWord(bool isCorrect) {
    if (isCorrect && isPaused == false) {
      score++;
      wordsCorrect.add(currentWord);
    }
    if (isPaused == false) {
      wordsPassed.add(currentWord);
      currentWord = _getRandomWord();
    }
  }

  void dispose() {
    _timer.cancel();
  }
}
