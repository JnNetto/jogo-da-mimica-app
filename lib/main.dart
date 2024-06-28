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
  }

  @override
  void dispose() {
    BackgroundMusicPlayer.disposeBackgroundMusic();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        BackgroundMusicPlayer.pauseBackgroundMusic();
        break;
      case AppLifecycleState.paused:
        BackgroundMusicPlayer.pauseBackgroundMusic();
        break;
      case AppLifecycleState.resumed:
        BackgroundMusicPlayer.resumeBackgroundMusic();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        break;
      case AppLifecycleState.detached:
        BackgroundMusicPlayer.stopBackgroundMusic();
        break;
      case AppLifecycleState.hidden:
        BackgroundMusicPlayer.pauseBackgroundMusic();
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
