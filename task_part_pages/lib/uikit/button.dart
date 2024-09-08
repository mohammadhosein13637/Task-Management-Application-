import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  //
  final String text;
  final Color textColor;
  final double  height;

  final void Function() onButtonPressed;

  const Button({
    super.key,
    required this.text,
    required this.textColor,
    this.height = 70,
   required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onButtonPressed,
        child: Container(
          
          height: height,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
