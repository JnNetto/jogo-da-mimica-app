import 'package:flutter/material.dart';
import 'package:mimica/src/utils/colors.dart';

import '../../utils/music.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  double _volume = BackgroundMusicPlayer.getVolume();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorsApp.color1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        height: 200.0,
        width: 300.0,
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
              value: _volume,
              activeColor: Colors.blueGrey,
              onChanged: (volume) {
                setState(() {
                  _volume = volume;
                });
                BackgroundMusicPlayer.setVolume(volume);
              },
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: "${(_volume * 100).toInt()}",
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child:
                    const Text('Fechar', style: TextStyle(color: Colors.white)),
                onPressed: () {
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
