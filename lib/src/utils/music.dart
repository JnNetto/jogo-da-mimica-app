import 'package:just_audio/just_audio.dart';

class BackgroundMusicPlayer {
  static late AudioPlayer _player;
  static double _volume = 0.3;

  static void initialize() {
    _player = AudioPlayer();
  }

  static Future<void> loadMusic(String musicPath) async {
    await _player.setAsset(musicPath);
  }

  static Future<void> playBackgroundMusic() async {
    if (_player.playing) return;
    await _player.setVolume(getVolume());
    await _player.play();
  }

  static Future<void> stopBackgroundMusic() async {
    if (!_player.playing) return;
    await _player.stop();
  }

  static Future<void> pauseBackgroundMusic() async {
    if (!_player.playing) return;
    await _player.pause();
  }

  static Future<void> resumeBackgroundMusic() async {
    if (_player.playing) return;
    await _player.play();
  }

  static Future<void> changeBackgroundMusic(String musicPath) async {
    await stopBackgroundMusic();
    await loadMusic(musicPath);
    await playBackgroundMusic();
  }

  static void setVolume(double volume) {
    _volume = volume;
    _player.setVolume(volume);
  }

  static double getVolume() {
    return _volume;
  }

  static disposeBackgroundMusic() {
    _player.dispose();
  }
}
