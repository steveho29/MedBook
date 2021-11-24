import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/controller/firestore.dart';
import 'package:medbook/models/appoinment.dart';
import 'package:medbook/models/doctor.dart';
import 'package:medbook/view/widgets/news_card.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  FirestoreController firestoreController = Get.find();
  AuthController authController = Get.find();
  // RxMap<String, Appointment> _listAppointments = <String, Appointment>{}.obs;
  // Map<String, Appointment> get listAppointments => _listAppointments.value;
  // RxMap<String, Doctor> _listDoctor = <String, Doctor>{}.obs;
  // Map<String, Doctor> get listDoctor => _listDoctor.value;

  bool isIncoming = true;
  Map<String, Appointment> x = {};
  Map<String, Doctor> d = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestoreController.getAppoinments().then((data) {
      // _listAppointments.value = data;
      this.setState(() {
        x = data;
      });

      print(data);
    });
    firestoreController.getDoctors().then((data) {
      this.setState(() {
        d = data;
      });
      // _listDoctor.value.addAll(data);
    });
  }

  List<Container> get listAppointmentItem {
    var data = x.values.toList();
    data.sort((a, b) => a.time.compareTo(b.time));

    return data
        .where((element) => isIncoming
            ? element.status == "Incoming"
            : element.status != "Incoming")
        .map((e) => AppointmentItem(e, d[e.doctorId]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 10,
                          color: Colors.grey,
                        )
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                    child: Text(
                      "Appointments",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 50),
                      AnimatedButtonBar(
                          radius: 32.0,
                          // padding: const EdgeInsets.only(16.0),
                          // backgroundColor: Colors.blueGrey.shade800,
                          backgroundColor: Colors.white,
                          // foregroundColor: Colors.blueGrey.shade300,
                          foregroundColor: Colors.green.shade100,
                          // elevation: 24,
                          // borderColor: Colors.white,
                          // borderWidth: 2,
                          innerVerticalPadding: 16,
                          children: [
                            ButtonBarEntry(
                              child: Text(
                                "Incoming",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              onTap: () => this.setState(() {
                                isIncoming = true;
                              }),
                            ),
                            ButtonBarEntry(
                              child: Text(
                                "History",
                                style: TextStyle(color: Colors.black),
                              ),
                              onTap: () => this.setState(() {
                                isIncoming = false;
                              }),
                            ),
                          ]),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(children: listAppointmentItem),
            ),
          ],
        ),
      ),
    );
  }
}

var AppointmentItem = (Appointment p, Doctor? d) => Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 1),
              blurRadius: 5,
            ),
          ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FaIcon(FontAwesomeIcons.bookMedical),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(d != null ? d.name : "", style: TextStyle(fontSize: 15)),
              Text(
                DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY)
                    .format(p.time.toDate()),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Spacer(),
          Badge(
            badgeColor: p.status == "Incoming" ? Colors.blue : Colors.red,
            child: Text(
              p.status,
              style: TextStyle(
                color: p.status == "Incoming" ? Colors.green : Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
