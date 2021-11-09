import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String userId, doctorId, reason, status;
  final Timestamp time;
  Appointment(
      {required this.userId,
      required this.doctorId,
      required this.time,
      required this.reason,
      this.status = "Incoming"});

  Appointment.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        doctorId = json['doctorId'],
        time = json['time'],
        reason = json['reason'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'userId': this.userId,
        'doctorId': this.doctorId,
        'time': this.time,
        'reason': this.reason,
        'status': this.status,
      };
}
