import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/controller/firestore.dart';
import 'package:medbook/models/appoinment.dart';
import 'package:medbook/models/doctor.dart';
import 'package:medbook/view/screens/appointment_detail_page.dart';
import 'package:medbook/view/widgets/selection_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorActivityPage extends StatefulWidget {
  const DoctorActivityPage({Key? key}) : super(key: key);
  @override
  _DoctorActivityPageState createState() => _DoctorActivityPageState();
}

class _DoctorActivityPageState extends State<DoctorActivityPage> {
  AuthController authController = Get.find();
  FirestoreController firestoreController = Get.find();
  Doctor? get doctor => authController.doctor.value;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Map<String, Appointment> appointments = <String, Appointment>{};
  // Map<String, Appointment> get appointments => _appointments;

  bool isIncoming = true;
  List<Widget> get listAppointmentItem => appointments.values
      .where((element) => doctor!.id == element.doctorId &&
              isSameDay(element.time.toDate(), _selectedDay) &&
              isIncoming
          ? element.status == "Incoming"
          : element.status != "Incoming")
      .map((e) => GestureDetector(
          onTap: () => {Get.to(() => AppointmentPage(appointment: e))},
          child: AppointmentItem(e)))
      .toList();
  @override
  void initState() {
    super.initState();
    firestoreController.getAppoinments().then((value) {
      print(value);

      this.setState(() {
        appointments = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: 50),
        AnimatedButtonBar(
            radius: 32.0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.green.shade100,
            innerVerticalPadding: 16,
            children: [
              ButtonBarEntry(
                child: Text(
                  "Incoming",
                  style: TextStyle(color: Colors.black, fontSize: 15),
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
        Column(children: listAppointmentItem),
      ]),
    );
  }
}

var AppointmentItem = (Appointment p) => Container(
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
          Container(
            width: 200,
            child: Column(
              children: [
                Text(p.reason,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 15, overflow: TextOverflow.ellipsis)),
                Text(
                  DateFormat(DateFormat.HOUR24_MINUTE).format(p.time.toDate()),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
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
