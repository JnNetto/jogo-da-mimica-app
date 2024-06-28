import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimica/src/utils/colors.dart';

class Button extends StatefulWidget {
  final double? elevation;
  final Color? buttonColor;
  final VoidCallback onPressed;
  final String label;

  const Button(
      {super.key,
      required this.elevation,
      required this.buttonColor,
      required this.onPressed,
      required this.label});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          shadowColor: MaterialStateProperty.all(ColorsApp.color4),
          elevation: MaterialStateProperty.all(widget.elevation),
        ),
        onPressed: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.label,
              style: GoogleFonts.girassol(
                  fontSize: 20,
                  textStyle: TextStyle(color: ColorsApp.letters))),
        ));
  }
}
