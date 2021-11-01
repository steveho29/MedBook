import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CovidCard extends StatefulWidget {
  final bool isVN;

  const CovidCard({required this.isVN});

  @override
  _CovidCardState createState() => _CovidCardState();
}

class _CovidCardState extends State<CovidCard> {
  var infections = '0'.obs, deaths = '0'.obs, recovers = '0'.obs;

  void fetchCovidAPI({required bool isVN}) async {
    String baseAPI =
        "https://crn-api.vgcloud.vn/ajax/api/getvnandtg/data.jsx?option=";
    var url = Uri.parse(isVN ? (baseAPI + '1') : (baseAPI + '0'));
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      infections.value =
          NumberFormat('###,###', 'en_US').format(data["data"]["confirmed"]);
      deaths.value =
          NumberFormat('###,###', 'en_US').format(data["data"]["deaths"]);
      recovers.value =
          NumberFormat('###,###', 'en_US').format(data["data"]["recovered"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchCovidAPI(isVN: widget.isVN);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.8,
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
              IconButton(
                icon: Icon(Icons.arrow_right_alt_sharp),
                onPressed: () => {},
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => CovidCaseText(type: 0, numCase: infections.value)),
              Obx(() => CovidCaseText(type: 1, numCase: deaths.value)),
              Obx(() => CovidCaseText(type: 2, numCase: recovers.value)),
            ],
          ),
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
          child: Text(
              widget.numCase.length > 8
                  ? widget.numCase.substring(0, 6) + '...'
                  : widget.numCase,
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
