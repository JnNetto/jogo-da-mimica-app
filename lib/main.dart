import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/utils/music.dart';
import 'src/views/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BackgroundMusicPlayer.initialize();
    BackgroundMusicPlayer.loadMusic1();
  }

  @override
  void dispose() {
    BackgroundMusicPlayer.disposeBackgroundMusic();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        BackgroundMusicPlayer.pauseBackgroundMusic(1);
        BackgroundMusicPlayer.pauseBackgroundMusic(2);
        BackgroundMusicPlayer.pauseBackgroundMusic(3);
        break;
      case AppLifecycleState.paused:
        BackgroundMusicPlayer.pauseBackgroundMusic(1);
        BackgroundMusicPlayer.pauseBackgroundMusic(2);
        BackgroundMusicPlayer.pauseBackgroundMusic(3);
        break;
      case AppLifecycleState.resumed:
        BackgroundMusicPlayer.resumeBackgroundMusic(1);
        BackgroundMusicPlayer.resumeBackgroundMusic(2);
        BackgroundMusicPlayer.resumeBackgroundMusic(3);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        break;
      case AppLifecycleState.detached:
        BackgroundMusicPlayer.stopBackgroundMusic(1);
        BackgroundMusicPlayer.stopBackgroundMusic(2);
        BackgroundMusicPlayer.stopBackgroundMusic(3);
        break;
      case AppLifecycleState.hidden:
        BackgroundMusicPlayer.pauseBackgroundMusic(1);
        BackgroundMusicPlayer.pauseBackgroundMusic(2);
        BackgroundMusicPlayer.pauseBackgroundMusic(3);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Jogo da mímica',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 0, 0, 0)),
          useMaterial3: true,
        ),
        home: Home());
  }
}
