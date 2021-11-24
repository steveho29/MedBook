import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/firestore.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/controller/main_controller.dart';
import 'package:medbook/view/screens/booking_success_page.dart';
import 'package:medbook/view/screens/login_page.dart';
import 'package:medbook/view/widgets/bottom_tab_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainPageController mainController = Get.put(MainPageController());
  // final FirestoreController firestoreController =
  //     Get.put(FirestoreController());
  // final FirestoreController t = Get.put(FirestoreController());
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return
        // Obx(
        //   () =>
        // mainController.currentPage != "Login"
        //     ? BookingPage()
        //     :
        Scaffold(
      bottomNavigationBar: BottomTabBar(),
      floatingActionButton: isKeyboardOpen
          ? null
          : FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => mainController.setPage("Booking"),
              child: Icon(Icons.calendar_today)),
      floatingActionButtonLocation:
          // FixedCenterDockedFabLocation(context: context),
          FloatingActionButtonLocation.centerDocked,
      body: Obx(() => mainController.currentPageWidget!),
    );
    // );
  }
}

class FixedCenterDockedFabLocation extends FloatingActionButtonLocation {
  const FixedCenterDockedFabLocation({
    this.context,
  });
  final context;

  @protected
  double getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;
    double bottomDistance = MediaQuery.of(context).viewInsets.bottom;

    double fabY = contentBottom + bottomDistance - fabHeight / 2.0;

    // The FAB should sit with a margin between it and the snack bar.
    if (snackBarHeight > 0.0) {
      fabY = min(
          fabY,
          contentBottom -
              snackBarHeight -
              fabHeight -
              kFloatingActionButtonMargin);
    }
    // The FAB should sit with its center in front of the top of the bottom sheet.
    if (bottomSheetHeight > 0.0) {
      fabY = min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);
    }

    final double maxFabY = scaffoldGeometry.scaffoldSize.height - fabHeight;
    return min(maxFabY, fabY);
  }

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2.0;
    return Offset(fabX, getDockedY(scaffoldGeometry));
  }
}
