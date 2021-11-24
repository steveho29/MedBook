import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/controller/firestore.dart';
import 'package:medbook/controller/main_controller.dart';
import 'package:medbook/controller/selection_controller.dart';
import 'package:medbook/models/appoinment.dart';
import 'package:medbook/models/doctor.dart';
import 'package:medbook/models/hospital.dart';
import 'package:medbook/view/widgets/BigButtonWidget.dart';
import 'package:medbook/view/widgets/date_bar.dart';
import 'package:medbook/view/widgets/dropup_box.dart';
import 'package:medbook/view/widgets/title_with_button.dart';

class BookingPage extends StatefulWidget {
  String location = "No Location";
  TimeOfDay time = TimeOfDay(hour: 7, minute: 30);
  Rx<DateTime> _currentDate = DateTime.now().obs;

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime get currentDate => widget._currentDate.value;

  SelectionController doctorController =
      SelectionController(callBack: () => {});

  SelectionController specialityController =
      SelectionController(callBack: () => {});
  SelectionController hospitalController =
      SelectionController(callBack: () => {});

  SelectionController locationController =
      SelectionController(callBack: () => {});

  SelectionController timeController = SelectionController(callBack: () => {});
  TextEditingController reasonController = TextEditingController();

  void clearSelection() {
    doctorController.setSelection("");
  }

  FirestoreController firestoreController = Get.find();
  AuthController authController = Get.find();

  // List<String> listLocations = ["Sài Gòn", "Hà Nội", "Đà Nẵng"];
  // List<String> listHospitals = ["Hospital 1", "Hospital 2", "Hospital 3"];
  final MainPageController mainPageController = Get.find();
  void setLocation(String location) {
    this.setState(() {
      widget.location = location;
    });
  }

  RxList<Doctor> _listDoctor = <Doctor>[].obs;
  RxMap<String, List<Hospital>> _listHospital = <String, List<Hospital>>{}.obs;
  List<Hospital> get listHospital {
    try {
      return _listHospital.value[locationController.currentSelection]!;
    } catch (e) {
      return [];
    }
  }

  List<Doctor> get listDoctor => _listDoctor.value;

  Hospital? get hospital {
    try {
      return listHospital
          .where(
              (element) => element.name == hospitalController.currentSelection)
          .first;
    } catch (e) {
      return null;
    }
  }

  List<Doctor> get doctors {
    try {
      var target = listDoctor
          .where(
              (element) => hospital!.doctorId.contains("doctors/" + element.id))
          .toList();
      return target;
    } catch (e) {
      return [];
    }
  }

  Doctor? get doctor {
    try {
      var target = listDoctor.firstWhere(
          (element) => element.name == doctorController.currentSelection);
      return target;
    } catch (e) {
      return null;
    }
  }

  void booking() async {
    // if (doctor != null && widget.time.hour != 0)
    {
      try {
        int index = timeController.currentSelection.indexOf(':');
        int hour =
            int.parse(timeController.currentSelection.substring(0, index));
        int minute =
            int.parse(timeController.currentSelection.substring(index + 1));
        Timestamp timestamp = Timestamp.fromDate(DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          hour,
          minute,
          // widget.time.hour,
          // widget.time.minute
        ));
        print(timestamp.toDate());
        firestoreController.makeAppoinment(
          Appointment(
            userId: authController.user.uid,
            doctorId: doctor!.id,
            time: timestamp,
            reason: reasonController.text,
          ),
        );
      } catch (error) {
        print(error);
        Get.snackbar(
          "Booking",
          "Incomplete",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Booking error",
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    }
  }

  List<String> get availableTime {
    if (doctor != null) {
      if (doctor!.exceptDay != null &&
          doctor!.exceptDay!.containsKey(currentDate)) {
        return doctor!.exceptDay![currentDate]!;
      }
      if (doctor!.exceptWeekday != null &&
          doctor!.exceptWeekday!.containsKey(currentDate.weekday))
        return doctor!.exceptWeekday![currentDate.weekday]!;
      return doctor!.daily.map((e) => e.toString()).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    Future(firestoreController.getDoctors)
        .then((data) => _listDoctor.value = data.values.toList());
    Future(firestoreController.getHospitals)
        .then((data) => _listHospital.value = data);
    specialityController.addCallBack(() => doctorController.setSelection(""));
    hospitalController.addCallBack(() => specialityController.setSelection(""));
    locationController.addCallBack(() => hospitalController.setSelection(""));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => mainPageController.back(),
          icon: Icon(
            Icons.close,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Appoinment",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TitleWithButton(
                title: "Your city",
                isShowButton: false,
              ),
              Obx(
                () => PopUpBox(
                  controller: locationController,
                  text: "Location",
                  selectionList: _listHospital.value.keys.toList(),
                  icon: Icon(Icons.location_on),
                ),
              ),
              TitleWithButton(
                title: "Hospital",
                isShowButton: false,
              ),
              Obx(
                () => PopUpBox(
                  controller: hospitalController,
                  text: "Hospital",
                  selectionList: listHospital.map((e) => e.name).toList(),
                  icon: FaIcon(FontAwesomeIcons.building),
                ),
              ),
              Obx(
                () => PopUpBox(
                  controller: specialityController,
                  text: "Speciality",
                  selectionList: doctors.map((e) => e.speciality).toList(),
                  icon: FaIcon(FontAwesomeIcons.book),
                ),
              ),
              Obx(
                () => PopUpBox(
                  controller: doctorController,
                  text: "Doctor",
                  selectionList: listDoctor
                      .where((element) =>
                          element.speciality ==
                          specialityController.currentSelection)
                      .map((e) => e.name)
                      .toList(),
                  icon: FaIcon(FontAwesomeIcons.peopleArrows),
                ),
              ),
              Obx(() => DateBar(
                    dateChanged: (date) =>
                        {widget._currentDate.value = date, print(date)},
                    inactiveWeekday:
                        doctor != null ? doctor!.inactiveWeekday : null,
                    inactiveDay: doctor != null ? doctor!.inactiveday : null,
                    exceptDay: doctor != null ? doctor!.acctiveExceptDay : null,
                  )),
              Obx(() => PopUpBox(
                  selectionList: availableTime,
                  text: "Available Time",
                  controller: timeController,
                  icon: FaIcon(FontAwesomeIcons.clock))),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //       height: 50,
              //       // width: MediaQuery.of(context).size.width * 0.6,
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.grey.shade200,
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Icon(Icons.hourglass_empty),
              //           Text(
              //             (widget.time.hour <= 12 ? "Morning " : "Afternoon ") +
              //                 (widget.time.hour.toString() +
              //                     ':' +
              //                     widget.time.minute.toString()),
              //             style: TextStyle(fontSize: 20),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Spacer(),
              //     ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10)),
              //         primary: Colors.orange,
              //       ),
              //       onPressed: () {
              //         Navigator.of(context).push(
              //           showPicker(
              //             iosStylePicker: true,
              //             is24HrFormat: true,
              //             minuteInterval: MinuteInterval.THIRTY,
              //             minHour: 7,
              //             maxHour: 16,
              //             context: context,
              //             value: TimeOfDay(hour: 7, minute: 30),
              //             onChange: (date) => {
              //               this.setState(() {
              //                 widget.time = date;
              //               })
              //             },
              //           ),
              //         );
              //       },
              //       child: Text(
              //         "Prefered Time",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(
                height: 20,
              ),
              TitleWithButton(
                title: "Reason",
                isShowButton: false,
              ),
              SizedBox(height: 10),
              TextField(
                controller: reasonController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Your issue ....',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.label_important_rounded),
                ),
                maxLines: 10,
              ),
              SizedBox(height: 20),
              BigButtonWidget(
                  text: "Book Appoinment", onClicked: () => booking()),
            ],
          ),
        ),
      ),
    );
  }
}
