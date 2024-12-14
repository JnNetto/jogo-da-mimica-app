import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimica_att/src/core/utils/colors.dart';

import '../utils/music.dart';

class Failure implements Exception {
  final String? message;

  Failure(this.message);

  @override
  String toString() => 'MyAppException: $message';

  static void showErrorDialog(BuildContext context, dynamic error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsApp.color1,
          title: Text(
            'Erro',
            style: GoogleFonts.girassol(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textStyle: TextStyle(color: ColorsApp.letters)),
          ),
          content: Text(
            error.toString(),
            style: GoogleFonts.girassol(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                textStyle: TextStyle(color: ColorsApp.letters)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                BackgroundMusicPlayer.loadMusic2();
                BackgroundMusicPlayer.playBackgroundMusic(2);
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
