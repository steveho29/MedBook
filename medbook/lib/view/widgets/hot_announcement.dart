import 'package:flutter/material.dart';

class HotAnnouncement extends StatefulWidget {
  final List<String> data;
  const HotAnnouncement({required this.data});

  @override
  _HotAnnouncementState createState() => _HotAnnouncementState();
}

class _HotAnnouncementState extends State<HotAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.data
            .map((e) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: HotAnccouncementTextBox(
                    title: e,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class HotAnccouncementTextBox extends StatefulWidget {
  final String title;

  const HotAnccouncementTextBox({required this.title});
  @override
  _HotAnccouncementTextBoxState createState() =>
      _HotAnccouncementTextBoxState();
}

class _HotAnccouncementTextBoxState extends State<HotAnccouncementTextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.green.shade50,
            ),
            child: Text(
              widget.title,
              maxLines: 2,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 10,
            child: Container(
              padding: EdgeInsets.all(5),
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.speaker_notes,
                    color: Colors.white,
                  ),
                  Text(
                    "NEW",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
