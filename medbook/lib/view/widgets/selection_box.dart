import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/selection_controller.dart';

class SelectionBox extends StatefulWidget {
  final String text;
  final Color color;
  final SelectionController selectionController;

  SelectionBox(
      {required this.text,
      this.color = Colors.green,
      required this.selectionController});
  @override
  _SelectionBoxState createState() => _SelectionBoxState();
}

class _SelectionBoxState extends State<SelectionBox> {
  bool get isChoose {
    return widget.selectionController.currentSelection == widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          this.setState(() {
            widget.selectionController.setSelection(widget.text);
          });
        },
        child: Obx(
          () => Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              border: isChoose ? Border.all(color: widget.color) : null,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  if (isChoose)
                    Icon(
                      Icons.done,
                      color: widget.color,
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
