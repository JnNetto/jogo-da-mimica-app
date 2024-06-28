import 'package:flutter/material.dart';
import 'package:mimica/src/utils/colors.dart';

class CustomIconButton extends StatefulWidget {
  final double? elevation;
  final double padding;
  final Color? buttonColor;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomIconButton(
      {super.key,
      required this.elevation,
      required this.buttonColor,
      required this.onPressed,
      required this.icon,
      required this.padding});

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
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
        icon: Padding(
          padding: EdgeInsets.all(widget.padding),
          child: Icon(
            widget.icon,
            color: Colors.white,
          ),
        ));
  }
}
