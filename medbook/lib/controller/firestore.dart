import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/models/appoinment.dart';
import 'package:medbook/models/doctor.dart';
import 'package:medbook/models/hospital.dart';
import 'package:medbook/view/screens/booking_success_page.dart';

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

class FirestoreController extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void addUser(String userId, Map<String, dynamic> data) async {
    // Call the user's CollectionReference to add a new user
    // await hospitals.get().then((QuerySnapshot snapshot) => {
    //       snapshot.docs.forEach((element) {
    //         print(element["name"]);
    //       })
    //     });
    // doctors.forEach((element) async {
    //   String? id = element['id'];
    //   element.remove('id');
    //   await hospitals.doc(id).set(element);
    // });
    await users.doc(userId).set(data);
  }

  void makeAppoinment(Appointment appointment) async {
    CollectionReference appoinments =
        FirebaseFirestore.instance.collection('appointments');
    CollectionReference userAppointments = FirebaseFirestore.instance
        .collection('users/${appointment.userId}/appointments');
    CollectionReference doctorAppointments = FirebaseFirestore.instance
        .collection('doctors/${appointment.doctorId}/appointments');
    //
    await appoinments.add(appointment.toJson()).then((value) {
      userAppointments.add({'reference': value});
      doctorAppointments.add({'reference': value});
    }).then((value) => Get.to(() => BookingSuccessPage()));
  }

  Future<Map<String, Appointment>> getAppoinments() async {
    AuthController authController = Get.find();
    String user = authController.isDoctor ? "doctors" : "users";
    CollectionReference userAppointments = FirebaseFirestore.instance
        .collection('${user}/${authController.user.uid}/appointments');
    Map<String, Appointment> appoinments = <String, Appointment>{};
    await userAppointments
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs.forEach((element) {
              ((element.data() as Map<String, dynamic>)['reference'])
                  .get()
                  .then((DocumentSnapshot snapshot) {
                appoinments.addAll({
                  snapshot.id: Appointment.fromJson(
                      snapshot.data() as Map<String, dynamic>),
                });
              });
            }));
    return appoinments;

    // return appoinments;
  }

  Future<Map<String, List<Hospital>>> getHospitals() async {
    CollectionReference hospitals =
        FirebaseFirestore.instance.collection("hospitals");

    final List<Hospital> listHospital = [];
    await hospitals
        .orderBy("city")
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs.forEach((element) {
              Map<String, dynamic> data =
                  element.data() as Map<String, dynamic>;
              List<String> doctors = [];
              (data['doctors'] as List<dynamic>)
                  .forEach((x) => doctors.add(x.path));
              data['doctors'] = doctors;
              listHospital.add(Hospital.fromJson(data));
            }));
    final releaseHospitals = listHospital.groupBy<String>((m) => m.city);
    print(releaseHospitals.keys.toList());
    return releaseHospitals;
  }

  Future<Map<String, Doctor>> getDoctors() async {
    // return Future.delayed(Duration(seconds: 4), () => {

    // });
    Map<String, Doctor> listDoctors = {};

    CollectionReference doctors =
        FirebaseFirestore.instance.collection('doctors/');
    // try {
    await doctors.get().then(
          (QuerySnapshot snapshot) => snapshot.docs.forEach(
            (element) {
              Map<String, dynamic> data =
                  element.data() as Map<String, dynamic>;
              data['id'] = element.id;
              // List<String> daily = [];
              // data['daily'].forEach((x) => daily.add(x.toString()));
              // data['daily'] = daily;

              // List<int> inactiveWeekday = [];
              // data['inactiveWeekday']
              //     .forEach((x) => inactiveWeekday.add(int.parse(x.toString())));
              // data['inactiveWeekday'] = inactiveWeekday;

              // List<DateTime> inactiveday = [];
              // data['inactiveday'].forEach((x) => inactiveday.add(x.toDate()));
              // data['inactiveday']  = inactiveday;
              listDoctors.addAll({
                element.id: Doctor.fromJson(
                  data,
                ),
              });
            },
          ),
        );
    // } catch (error) {
    //   print("getdoctor");
    //   print(error);
    // }
    // await getHospitals();
    // print(listDoctors[0]);
    return listDoctors;
  }

  Future<Doctor?> isDoctor() async {
    AuthController authController = Get.find();
    if (authController.isSignIn == false) return null;
    CollectionReference doctors =
        FirebaseFirestore.instance.collection('doctors');
    Doctor? target = null;
    print(authController.user.uid);
    await doctors.get().then((QuerySnapshot snapshot) => snapshot.docs
            .where((element) => (element.id == authController.user.uid))
            .forEach((e) {
          Map<String, dynamic> data = e.data() as Map<String, dynamic>;
          data['id'] = e.id;
          print(e.id);
          target = Doctor.fromJson(data);
        }));

    return target;
  }
}


// Check if user is doctor
