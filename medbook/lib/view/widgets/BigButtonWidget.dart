import 'package:flutter/material.dart';

class BigButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  var textColor;
  BigButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
          shape: StadiumBorder(),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: this.textColor,
            ),
          ),
        ),
        onPressed: onClicked,
      );
}
