import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:medbook/controller/fetch_covid_api.dart';
import 'package:medbook/view/widgets/covid_source_text.dart';

class CovidContainer extends StatefulWidget {
  final bool isVN;
  final CovidData data;

  const CovidContainer({required this.data, required this.isVN});

  @override
  _CovidContainerState createState() => _CovidContainerState();
}

class _CovidContainerState extends State<CovidContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // height: MediaQuery.of(context).size.height * 0.2,
      // width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(0, 5),
              blurRadius: 5,
            )
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                widget.isVN
                    ? "assets/images/vn_flag.png"
                    : "assets/images/world_flag.png",
                width: 30,
              ),
              Text(
                widget.isVN ? "  Vietnam" : "   World",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Spacer(),
            ],
          ),
          CovidCaseText(type: 0, numCase: widget.data.infections),
          CovidCaseText(type: 1, numCase: widget.data.deaths),
          CovidCaseText(type: 2, numCase: widget.data.recovers),
        ],
      ),
    );
  }
}

class CovidCaseText extends StatefulWidget {
  final int type;
  final String numCase;

  final bColor = {
    0: Colors.red.shade100,
    1: Colors.grey.shade200,
    2: Colors.green.shade100,
  };

  final tColor = {
    0: Colors.red,
    1: Colors.grey,
    2: Colors.green,
  };

  final text = {
    0: "Infections",
    1: "Deaths",
    2: "Recoveries",
  };

  CovidCaseText({required this.type, required this.numCase});
  @override
  _CovidCaseTextState createState() => _CovidCaseTextState();
}

class _CovidCaseTextState extends State<CovidCaseText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.bColor[widget.type],
          ),
          child: Text(widget.numCase,
              style: TextStyle(
                color: widget.tColor[widget.type],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        SizedBox(height: 10),
        Text(widget.text[widget.type]!, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class CovidPage extends StatefulWidget {
  CovidData vn = new CovidData();
  CovidData world = new CovidData();
  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  bool isFetch = false;
  @override
  Widget build(BuildContext context) {
    if (!isFetch) {
      fetchCovidAPI(isVN: true).then((value) => this.setState(() {
            widget.vn = value;
          }));
      fetchCovidAPI(isVN: false).then((value) => this.setState(() {
            widget.world = value;
          }));
    }

    isFetch = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Infomation"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CovidContainer(
              data: widget.vn,
              isVN: true,
            ),
            CovidContainer(
              data: widget.world,
              isVN: false,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CovidSourceText(time: widget.vn.lastUpdate),
            ),
          ],
        ),
      ),
    );
  }
}
