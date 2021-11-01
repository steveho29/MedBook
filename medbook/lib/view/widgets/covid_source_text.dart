import 'package:flutter/material.dart';

class CovidSourceText extends StatefulWidget {
  final String time;
  const CovidSourceText({required this.time});
  @override
  _CovidSourceTextState createState() => _CovidSourceTextState();
}

class _CovidSourceTextState extends State<CovidSourceText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            Text(
              "Updated at: ",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.time,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            Spacer(),
            Text(
              "Source: ",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            Text(
              "Vietnam Ministry Of Healthy",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ],
    );
  }
}
