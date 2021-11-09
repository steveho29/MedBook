import 'package:flutter/material.dart';

class MenuIcon extends StatefulWidget {
  final String name;
  var menuIcon;
  final void Function() onClick;
  MenuIcon({required this.name, required this.menuIcon, required this.onClick});
  @override
  _MenuIconState createState() => _MenuIconState();
}

class _MenuIconState extends State<MenuIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).primaryColor.withOpacity(0.15),
          ),
          child: IconButton(
              color: Theme.of(context).primaryColor,
              icon: widget.menuIcon,
              iconSize: 35,
              onPressed: () => widget.onClick()),
        ),
        SizedBox(height: 5),
        Text(
          widget.name,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
