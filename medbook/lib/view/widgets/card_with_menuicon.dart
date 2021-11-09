import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'menu_icon.dart';

class CardWithMenuIcon extends StatefulWidget {
  final String name;
  var menuIcon;
  CardWithMenuIcon({required this.name, required this.menuIcon});
  @override
  _CardWithMenuIconState createState() => _CardWithMenuIconState();
}

class _CardWithMenuIconState extends State<CardWithMenuIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: MenuIcon(
        onClick: () => {},
        menuIcon: widget.menuIcon,
        name: widget.name,
      ),
    );
  }
}
