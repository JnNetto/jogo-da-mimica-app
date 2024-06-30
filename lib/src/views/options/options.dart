import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimica/src/utils/colors.dart';

import '../../utils/music.dart';

class Options extends StatefulWidget {
  final BoxConstraints constraints;

  const Options(this.constraints, {super.key});

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
        width: widget.constraints.maxWidth * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Opções',
                style: GoogleFonts.girassol(
                    fontSize: 28,
                    textStyle: TextStyle(color: ColorsApp.letters))),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text('Volume da música',
                    style: GoogleFonts.girassol(
                        fontSize: 17,
                        textStyle: TextStyle(color: ColorsApp.letters))),
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
              ],
            ),
            Column(
              children: [
                Text('Volume do toque',
                    style: GoogleFonts.girassol(
                        fontSize: 17,
                        textStyle: TextStyle(color: ColorsApp.letters))),
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Text('Fechar',
                    style: GoogleFonts.girassol(
                        fontSize: 15,
                        textStyle: TextStyle(color: ColorsApp.letters))),
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
