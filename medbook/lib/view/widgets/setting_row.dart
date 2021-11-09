import 'package:flutter/material.dart';

class SettingRow extends StatefulWidget {
  final String text, subText;
  var icon;
  final Color color;
  final void Function() onClick;
  SettingRow(
      {required this.text,
      required this.subText,
      required this.icon,
      required this.color,
      required this.onClick});
  @override
  _SettingRowState createState() => _SettingRowState();
}

class _SettingRowState extends State<SettingRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick(),
      child: Row(
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: widget.color.withOpacity(0.15),
            ),
            child: Icon(
              widget.icon,
              color: widget.color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                widget.text,
                style: TextStyle(fontSize: 18),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Spacer(),
          Text(
            widget.subText,
            style: TextStyle(color: Colors.grey),
          ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
