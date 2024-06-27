import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mimica/src/utils/words.dart';

class GameController {
  final List<String> categorys;
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
      {required this.categorys,
      required this.initialTime,
      required this.onTimeUp})
      : remainingTime = ValueNotifier<int>(initialTime) {
    words = _getWordsForCategory(categorys);
    currentWord = _getRandomWord();
    _startTimer();
  }

  List<String> _getWordsForCategory(List<String> categorys) {
    List<String> words = [];
    for (String category in categorys) {
      switch (category) {
        case 'Geral':
          words.addAll(ListWords.geral);
        case 'Verbos':
          words.addAll(ListWords.verbos);
        case 'Filmes':
          words.addAll(ListWords.filmes);
        case 'Animais':
          words.addAll(ListWords.animais);
        case 'Objetos':
          words.addAll(ListWords.objetos);
        case 'Profissões':
          words.addAll(ListWords.profissoes);
        default:
          words.addAll([]);
      }
    }
    return words;
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
