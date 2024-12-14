import 'dart:async';
import 'package:flutter/material.dart';
import '../core/utils/music.dart';
import '../core/utils/words.dart';

class GameController {
  final List<String> categorys;
  final int initialTime;
  final ValueNotifier<int> remainingTime;
  final Map<String, List<String>> customCategories;
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
      required this.onTimeUp,
      required this.customCategories})
      : remainingTime = ValueNotifier<int>(initialTime) {
    words = _getWordsForCategory(categorys);
    currentWord = _getRandomWord();
    delayedStartTimer();
  }

  Future<void> delayedStartTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    _startTimer();
  }

  List<String> _getWordsForCategory(List<String> categorys) {
    List<String> words = [];
    for (String category in categorys) {
      if (customCategories.isEmpty) {
        switch (category) {
          case 'Geral':
            words.addAll(ListWords.geral);
            break;
          case 'Verbos':
            words.addAll(ListWords.verbos);
            break;
          case 'Filmes':
            words.addAll(ListWords.filmes);
            break;
          case 'Animais':
            words.addAll(ListWords.animais);
            break;
          case 'Objetos':
            words.addAll(ListWords.objetos);
            break;
          case 'Profissões':
            words.addAll(ListWords.profissoes);
            break;
          default:
            words.addAll([]);
        }
      } else {
        if (customCategories[category] != null) {
          words.addAll(customCategories[category] ?? []);
        }
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
      if (remainingTime.value <= 11 && remainingTime.value > 0 && !isPaused) {
        remainingTime.value--;

        _playTickSound();
      } else if (remainingTime.value > 0 && !isPaused) {
        remainingTime.value--;
      } else if (remainingTime.value == 0) {
        _timer.cancel();
        BackgroundMusicPlayer.loadMusic5();
        _playWhistleSound();
        onTimeUp();
      }
    });
  }

  Future<void> _playTickSound() async {
    try {
      BackgroundMusicPlayer.loadMusic3();
      BackgroundMusicPlayer.playBackgroundMusic(3);
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> _playWhistleSound() async {
    try {
      BackgroundMusicPlayer.playBackgroundMusic(5);
      // ignore: empty_catches
    } catch (e) {}
  }

  void pauseTimer() {
    isPaused = !isPaused;
    if (isPaused) {
      BackgroundMusicPlayer.pauseBackgroundMusic(3);
    } else {
      BackgroundMusicPlayer.resumeBackgroundMusic(3);
    }
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
}
