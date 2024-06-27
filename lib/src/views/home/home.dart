import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';
import '../categorys/categorys.dart';
import '../options/options.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double? elevation = 10;

    Widget title() {
      return Text("Mímica",
          style: GoogleFonts.girassol(
              fontSize: 60, textStyle: TextStyle(color: ColorsApp.letters)));
    }

    Widget playButton(BuildContext context, double? elevation) {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsApp.color1),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          shadowColor: MaterialStateProperty.all(ColorsApp.color4),
          elevation: MaterialStateProperty.all(elevation),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Category()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Jogar',
              style: GoogleFonts.girassol(
                  fontSize: 20,
                  textStyle: TextStyle(color: ColorsApp.letters))),
        ),
      );
    }

    Widget optionsButton(BuildContext context, double? elevation) {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsApp.color1),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          shadowColor: MaterialStateProperty.all(ColorsApp.color4),
          elevation: MaterialStateProperty.all(8),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => Options(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Opções',
              style: GoogleFonts.girassol(
                  fontSize: 20,
                  textStyle: TextStyle(color: ColorsApp.letters))),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: ColorsApp.background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title(),
              const SizedBox(height: 20),
              playButton(context, elevation),
              const SizedBox(height: 20),
              optionsButton(context, elevation)
            ],
          ),
        ),
      ),
    );
  }
}
