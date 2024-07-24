import 'package:flutter/material.dart';

import '../utils/colors.dart';

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
          backgroundColor: WidgetStateProperty.all(widget.buttonColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          shadowColor: WidgetStateProperty.all(ColorsApp.color4),
          elevation: WidgetStateProperty.all(widget.elevation),
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
