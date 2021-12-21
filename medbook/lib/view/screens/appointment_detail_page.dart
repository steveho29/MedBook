import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/controller/firestore_controller.dart';
import 'package:medbook/controller/selection_controller.dart';
import 'package:medbook/models/appoinment.dart';
import 'package:medbook/models/prescription.dart';
import 'package:medbook/view/widgets/dropup_box.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentPage extends StatefulWidget {
  final Appointment appointment;
  List<Map<String, dynamic>> listPill = [
    // {
    //   'name': 'Panadol',
    //   'dose': '1 Breakfast|1 Lunch|1 Dinner',
    //   'note': 'After meal',
    //   'color': Colors.red.shade50,
    //   'pillColor': Colors.red.shade300,
    // }
  ];
  int get pillColorIdx => listPill.length % pillColors.length;

  List<Map<String, Color>> pillColors = [
    {
      'color': Colors.red.shade50,
      'pillColor': Colors.red.shade300,
    },
    {
      'color': Colors.blue.shade50,
      'pillColor': Colors.blue.shade300,
    },
    {
      'color': Colors.orange.shade50,
      'pillColor': Colors.orange.shade300,
    },
    {
      'color': Colors.grey.shade100,
      'pillColor': Colors.grey.shade300,
    },
  ];
  AppointmentPage({required this.appointment}) {
    appointment.prescriptions.forEach((e) {
      listPill.add({
        'name': e.name,
        'dose': e.dose,
        'note': e.note,
        'color': pillColors[pillColorIdx]['color'],
        'pillColor': pillColors[pillColorIdx]['pillColor']
      });
    });
    // listPill.addAll(appointment.prescriptions
    //     .map((e) => {
    //           'name': e.name,
    //           'dose': e.dose,
    //           'note': e.note,
    //           'color': pillColors[pillColorIdx]['color'],
    //           'pillColor': pillColors[pillColorIdx]['pillColor']
    //         })
    //     .toList());
  }
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController doseTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  TextEditingController diseaseTextController = TextEditingController();
  SelectionController timeSelectionController =
      SelectionController(callBack: () => {});

  FirestoreController firestoreController = Get.find();
  AuthController authController = Get.find();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now().add(Duration(days: 7));

  void update() {
    List<Presciption> prescriptions = [];
    widget.listPill.forEach((element) {
      prescriptions.add(new Presciption(
          name: element['name'], dose: element['dose'], note: element['note']));
    });
    widget.appointment.prescriptions = prescriptions;
    // widget.appointment.reason = TextController.text;
    firestoreController.updateAppointment(widget.appointment);
    Get.snackbar(
      "Appointment",
      "Appointment",
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        "Update Successfully",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    diseaseTextController.text = widget.appointment.reason;
    print(widget.appointment.reason);
    print(widget.appointment.prescriptions.length);
    diseaseTextController.addListener(() {
      widget.appointment.reason = diseaseTextController.text;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Appointment"),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 2), color: Colors.grey, blurRadius: 5)
                  ],
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(50),
                    bottomEnd: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(DateTime.now().year),
                    lastDay: DateTime.utc(DateTime.now().year + 1, 12),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      // Use `selectedDayPredicate` to determine which day is currently selected.
                      // If this returns true, then `day` will be marked as selected.

                      // Using `isSameDay` is recommended to disregard
                      // the time-part of compared DateTime objects.
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        // Call `setState()` when updating calendar format
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      _focusedDay = focusedDay;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Next Appointment: ${DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).format(_selectedDay)}",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  if (authController.isDoctor)
                    Obx(() => PopUpBox(
                        selectionList: authController.doctor.value!
                            .availableTime(_selectedDay),
                        text: "Available Time",
                        controller: timeSelectionController,
                        icon: FaIcon(FontAwesomeIcons.clock))),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Medicine",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Spacer(),
                      if (authController.isDoctor)
                        IconButton(
                            onPressed: () => {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30),
                                    )),
                                    builder: (context) => Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      padding: EdgeInsets.all(30),
                                      child: ListView(
                                        children: [
                                          SizedBox(height: 20),
                                          Text(
                                            "Add new medicine",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Name",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          TextField(
                                            controller: nameTextController,
                                            decoration: InputDecoration(
                                              hintText: 'Name',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              // prefixIcon:
                                              //     Icon(Icons.label_important_rounded),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Dose",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          TextField(
                                            controller: doseTextController,
                                            decoration: InputDecoration(
                                              hintText: 'Dose',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              // prefixIcon:
                                              //     Icon(Icons.label_important_rounded),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Note",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          TextField(
                                            maxLines: 2,
                                            controller: noteTextController,
                                            decoration: InputDecoration(
                                              hintText: 'Note',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              // prefixIcon:
                                              //     Icon(Icons.label_important_rounded),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              this.setState(() {
                                                widget.listPill.add({
                                                  'name':
                                                      nameTextController.text,
                                                  'dose':
                                                      doseTextController.text,
                                                  'note':
                                                      noteTextController.text,
                                                  'pillColor': widget
                                                              .pillColors[
                                                          widget.pillColorIdx]
                                                      ['pillColor'],
                                                  'color': widget.pillColors[
                                                          widget.pillColorIdx]
                                                      ['color'],
                                                });
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("Add",
                                                style: TextStyle(fontSize: 20)),
                                            style: ElevatedButton.styleFrom(
                                              primary: Theme.of(context)
                                                  .primaryColor,
                                              minimumSize: Size.fromHeight(50),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                },
                            icon: Icon(Icons.add)),
                    ],
                  ),
                  Column(
                    children: widget.listPill
                        .map((e) => pillItem(
                            context,
                            e['name'],
                            e['dose'],
                            e['note'],
                            e['pillColor'],
                            e['color'],
                            authController.isDoctor,
                            () => this.setState(() {
                                  widget.listPill.remove(e);
                                })))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: diseaseTextController,
                      autofocus: false,
                      maxLines: 5,
                      decoration: InputDecoration(
                          labelText: "Disease",
                          labelStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                  ),
                  if (authController.isDoctor)
                    ElevatedButton(
                      onPressed: () => update(),
                      child: Text(
                        "Confirm",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.9, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  var pillItem =
      (context, name, dose, note, pillColor, color, canClose, onClosed) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.white,
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.pills,
                color: pillColor,
                size: 50,
              ),
            ],
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                // Spacer(),
                Text(dose,
                    style: TextStyle(
                      fontSize: 20,
                    )),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child:
                      Text(note, maxLines: 3, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Spacer(),
          if (canClose)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: onClosed,
            ),
        ],
      ),
    );
  };
}
