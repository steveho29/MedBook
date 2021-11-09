import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/main_controller.dart';
import 'package:medbook/view/screens/main_page.dart';

class BookingSuccessPage extends StatefulWidget {
  const BookingSuccessPage({Key? key}) : super(key: key);

  @override
  _BookingSuccessPageState createState() => _BookingSuccessPageState();
}

class _BookingSuccessPageState extends State<BookingSuccessPage> {
  MainPageController mainPageController = Get.find();
  void close() {
    mainPageController.setPage("Activity");
    Get.to(() => MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => close(),
            icon: Icon(
              Icons.close,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Booking Successful",
                maxLines: 2,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              Text(
                "Our agent will contact you shortly to confirm",
                maxLines: 3,
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                // padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: FaIcon(
                        FontAwesomeIcons.calendarAlt,
                        size: 100,
                        color: Colors.orange,
                      ),
                    ),
                    Positioned(
                      left: 50,
                      child: Icon(
                        Icons.done_all,
                        // color: Theme.of(context).primaryColor,
                        color: Colors.green,
                        size: 100,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    minimumSize: Size(MediaQuery.of(context).size.width, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => close(),
                  child: Text(
                    "Close",
                    style: TextStyle(fontSize: 30),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
