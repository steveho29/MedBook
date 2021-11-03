import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/selection_controller.dart';
import 'package:medbook/view/widgets/dropup_box.dart';
import 'package:medbook/view/widgets/selection_bottom_sheet.dart';
import 'package:medbook/view/widgets/selection_box.dart';

class BookingPage extends StatefulWidget {
  String location = "No Location";

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  SelectionController locationController = SelectionController();
  SelectionController hospitalController = SelectionController();
  List<String> listLocations = ["Sài Gòn", "Hà Nội", "Đà Nẵng"];
  List<String> listHospitals = ["Hospital 1", "Hospital 2", "Hospital 3"];
  void setLocation(String location) {
    this.setState(() {
      widget.location = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          DropUpBox(
            controller: locationController,
            text: "Location",
            selectionList: listLocations,
            icon: Icon(Icons.location_on),
          ),
          DropUpBox(
            controller: hospitalController,
            text: "Hospital",
            selectionList: listHospitals,
            icon: FaIcon(FontAwesomeIcons.building),
          ),
        ],
      ),
    );
  }
}
