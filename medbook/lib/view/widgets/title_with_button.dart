import 'package:flutter/material.dart';

class TitleWithButton extends StatefulWidget {
  final String title;
  final bool isShowButton;
  TitleWithButton({required this.title, this.isShowButton = true});
  @override
  _TitleWithButtonState createState() => _TitleWithButtonState();
}

class _TitleWithButtonState extends State<TitleWithButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          if (widget.isShowButton)
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade400,
              ),
              child: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () => {},
                icon: Icon(Icons.chevron_right),
                iconSize: 25,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
