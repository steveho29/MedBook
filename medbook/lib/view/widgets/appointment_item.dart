import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medbook/models/appoinment.dart';

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
