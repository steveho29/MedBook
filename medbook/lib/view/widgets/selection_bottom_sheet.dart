import 'package:flutter/material.dart';
import 'package:medbook/view/widgets/selection_box.dart';

var SelectionBottomSheet = (
    {required context, required String text, required List<String> selectionList, required selectionController}) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(30),
    )),
    context: context,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(30),
      child: ListView(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: selectionList
                .map(
                  (e) => SelectionBox(
                    text: e,
                    selectionController: selectionController, 
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ),
  );
};
