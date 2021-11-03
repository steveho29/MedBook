import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/selection_controller.dart';
import 'package:medbook/view/widgets/selection_bottom_sheet.dart';

class DropUpBox extends StatefulWidget {
  final List<String> selectionList;
  final String text;
  final SelectionController controller;
  final bool isRequired;
  var icon;
  DropUpBox(
      {required this.selectionList,
      required this.text,
      required this.controller,
      required this.icon,
      this.isRequired = false});
  @override
  _DropUpBoxState createState() => _DropUpBoxState();
}

class _DropUpBoxState extends State<DropUpBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              SelectionBottomSheet(
                  text: widget.text,
                  selectionController: widget.controller,
                  selectionList: widget.selectionList,
                  context: context)
            },
        child: Obx(
          () => Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.icon,
                  if (widget.isRequired)
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.controller.currentSelection.value,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
