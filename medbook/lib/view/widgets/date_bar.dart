import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class DateBar extends StatefulWidget {
  final void Function(DateTime) dateChanged;
  DateTime date = DateTime.now();
  List<int>? inactiveWeekday;
  List<DateTime>? inactiveDay;
  List<DateTime>? exceptDay;
  DateBar({required this.dateChanged, this.inactiveWeekday, this.inactiveDay, this.exceptDay});
  @override
  _DateBarState createState() => _DateBarState();
}

class _DateBarState extends State<DateBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: DatePicker(
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          daysCount: 30,
          height: 100.0,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: Theme.of(context).primaryColor,
          //selectedTextColor: primaryClr,
          deactivatedColor: Colors.grey,
          inactiveDates: widget.inactiveDay,
          inactiveWeekDay: widget.inactiveWeekday,
          exceptDay: widget.exceptDay,
          selectedTextColor: Colors.white,
          // dateTextStyle: GoogleFonts.lato(
          //   textStyle: TextStyle(
          //     fontSize: 20.0,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey,
          //   ),
          // ),
          // dayTextStyle: GoogleFonts.lato(
          //   textStyle: TextStyle(
          //     fontSize: 16.0,
          //     color: Colors.grey,
          //   ),
          // ),
          // monthTextStyle: GoogleFonts.lato(
          //   textStyle: TextStyle(
          //     fontSize: 10.0,
          //     color: Colors.grey,
          //   ),
          // ),

          onDateChange: (date) {
            this.setState(() {
              date = date;
            });
            widget.dateChanged(date);
          },
        ),
      ),
    );
  }
}
