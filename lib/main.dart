import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mimica/src/utils/splash_screen.dart';
import 'src/utils/music.dart';

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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    BackgroundMusicPlayer.initialize();
    BackgroundMusicPlayer.loadMusic1();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    BackgroundMusicPlayer.disposeBackgroundMusic();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        BackgroundMusicPlayer.pauseBackgroundMusic(1);
        BackgroundMusicPlayer.pauseBackgroundMusic(2);
        BackgroundMusicPlayer.pauseBackgroundMusic(3);
        BackgroundMusicPlayer.pauseBackgroundMusic(4);
        BackgroundMusicPlayer.pauseBackgroundMusic(5);
        break;
      case AppLifecycleState.resumed:
        BackgroundMusicPlayer.resumeBackgroundMusic(1);
        BackgroundMusicPlayer.resumeBackgroundMusic(2);
        BackgroundMusicPlayer.resumeBackgroundMusic(3);
        BackgroundMusicPlayer.resumeBackgroundMusic(4);
        BackgroundMusicPlayer.resumeBackgroundMusic(5);
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
        BackgroundMusicPlayer.stopBackgroundMusic(4);
        BackgroundMusicPlayer.stopBackgroundMusic(5);
        break;
      case AppLifecycleState.hidden:
        BackgroundMusicPlayer.pauseBackgroundMusic(1);
        BackgroundMusicPlayer.pauseBackgroundMusic(2);
        BackgroundMusicPlayer.pauseBackgroundMusic(3);
        BackgroundMusicPlayer.pauseBackgroundMusic(4);
        BackgroundMusicPlayer.pauseBackgroundMusic(5);
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
        home: const SplashPage());
  }
}
