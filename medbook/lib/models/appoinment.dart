import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medbook/models/prescription.dart';

class Appointment {
  final String userId, doctorId, status, id;
  String reason;
  final Timestamp time;
  List<Presciption> prescriptions = [];
  Appointment(
      {required this.userId,
      required this.doctorId,
      required this.time,
      required this.reason,
      required this.id,
      this.status = "Incoming"});

  Appointment.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        doctorId = json['doctorId'],
        time = json['time'],
        reason = json['reason'],
        status = json['status'],
        prescriptions = json.containsKey('prescription')
            ? (json['prescription'] as List<dynamic>).map((e) {
                return Presciption(
                    name: e['name'], dose: e['dose'], note: e['note']);
              }).toList()
            : [],
        // nextDay = json.containsKey('nextDay') ? json['nextDay'].toString() : '',
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'userId': this.userId,
        'doctorId': this.doctorId,
        'time': this.time,
        'reason': this.reason,
        'status': this.status,
      };
}
