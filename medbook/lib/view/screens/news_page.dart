import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/main_controller.dart';
import 'package:medbook/view/screens/home_page.dart';

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
  MainPageController mainPageController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      widget.title,
                      maxLines: 15,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Html(data: widget.content)

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
