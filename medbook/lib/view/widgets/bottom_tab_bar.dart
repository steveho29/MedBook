import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/main_controller.dart';

Widget buildTabItem(
    {@required changePageCallBack, @required page, @required icon}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
          height: 25,
          margin: EdgeInsets.only(bottom: 10),
          child: IconButton(
            icon: icon,
            onPressed: () => changePageCallBack(page),
          )),
      Text(page),
    ],
  );
}

class BottomTabBar extends GetWidget {
  final MainPageController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTabItem(
                changePageCallBack: mainController.goToPage,
                page: "Home",
                icon: Icon(
                  Icons.home,
                )),
            buildTabItem(
                changePageCallBack: mainController.goToPage,
                page: "Activity",
                icon: Icon(Icons.contact_page_outlined)),
            Opacity(
                opacity: 0,
                child: IconButton(
                  icon: Icon(Icons.no_cell),
                  onPressed: null,
                )),
            // Spacer(),
            buildTabItem(
                changePageCallBack: mainController.goToPage,
                page: "Notification",
                icon: Icon(
                  Icons.notifications,
                  semanticLabel: "Notification",
                )),
            buildTabItem(
                changePageCallBack: mainController.goToPage,
                page: "Account",
                icon: Icon(Icons.account_circle)),
          ],
        ));
  }
}
