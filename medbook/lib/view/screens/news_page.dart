import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_page.dart';

class NewsPage extends StatefulWidget {
  String title, content;

  NewsPage({required this.title, required this.content}) {
    this.title = title;
    this.content = content;
  }

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(() => MainPage()),
            icon: Icon(
              Icons.close,
              color: Colors.black,
            )),
        title: Container(
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Column(
            children: [
              // Text(widget.content, style: TextStyle(
              //   fontSize: 15
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
