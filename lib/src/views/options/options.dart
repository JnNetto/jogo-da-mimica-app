import 'package:flutter/material.dart';
import 'package:mimica/src/utils/colors.dart';

import '../../utils/music.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  double volume1 = BackgroundMusicPlayer.getVolumeMusic();
  double volume2 = BackgroundMusicPlayer.getVolumeSound();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorsApp.color1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Opções',
                style: TextStyle(fontSize: 24.0, color: ColorsApp.letters)),
            const SizedBox(
              height: 20,
            ),
            const Text('Volume da música',
                style: TextStyle(color: Colors.white)),
            Slider(
              value: volume1,
              activeColor: Colors.blueGrey,
              onChanged: (volume) {
                setState(() {
                  volume1 = volume;
                });
                BackgroundMusicPlayer.setVolume(volume, 1);
              },
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: "${(volume1 * 100).toInt()}",
            ),
            Slider(
              value: volume2,
              activeColor: Colors.blueGrey,
              onChanged: (volume) {
                setState(() {
                  volume2 = volume;
                });
                BackgroundMusicPlayer.setVolume(volume, 2);
              },
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: "${(volume2 * 100).toInt()}",
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child:
                    const Text('Fechar', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  BackgroundMusicPlayer.loadMusic2();
                  BackgroundMusicPlayer.playBackgroundMusic(2);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
