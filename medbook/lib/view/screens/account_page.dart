import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/controller/main_controller.dart';
import 'package:medbook/view/screens/login_page.dart';
import 'package:medbook/view/widgets/news_card.dart';
import 'package:medbook/view/widgets/setting_row.dart';
import 'package:medbook/view/widgets/title_with_button.dart';

class AccountPage extends StatelessWidget {
  List<Map<String, String>> _newsData = [
    {
      "title": "Campuchia tặng Việt Nam 200 nghìn liều vaccine ngừa Covid-19",
      "time": "29/10/2001",
      "imageLink":
          "https://covid19.qltns.mediacdn.vn/354844073405468672/2021/10/29/a1-1635500935963-1635507337867-1635507338559319018096.jpg",
    },
    {
      "title":
          "Tập huấn toàn quốc chiến dịch tiêm vaccine COVID-19 cho học sinh",
      "time": "29/10/2001",
      "imageLink":
          "http://baochinhphu.vn/Uploaded/nguyenthuyha/2021_10_28/2110272102%20(1).jpg",
    },
    {
      "title":
          "THẢM HỌA Ở OLD TRAFFORD: MU thất bại nhục nhã chưa từng thấy trước \"kẻ thù\" Liverpool",
      "time": "29/10/2001",
      "imageLink":
          "https://kenh14cdn.com/thumb_w/620/203336854389633024/2021/10/25/gettyimages-1348620112-2048x2048-16350991238101625103239.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    double sectionPadding = 20;
    MainPageController mCtrler = Get.find();
    AuthController authController = Get.find();
    return SingleChildScrollView(
      child: Column(
        children: [
          // ------- CLIPER AND NEWS ----------
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0.1),
                ),
              ],
            ),
            child: Container(
              child: Stack(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/user_bg.png"),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Obx(
                              () => authController.isSignIn &&
                                      authController.user.photoURL != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        authController.user.photoURL!,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/avatar.svg',
                                      width: 100,
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.center,
                                    ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Obx(
                              () => Text(
                                authController.isSignIn
                                    ? authController.user.displayName != null
                                        ? authController.user.displayName!
                                        : authController.user.email!
                                    : "Not sign in",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade400,
                                ),
                              ),
                            ),
                          ),

                          // I dont know why it can't work without container
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4 - 80),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 10, left: 20, right: 20),
                      child: Column(
                        children: [
                          TitleWithButton(title: "Recent Activities"),
                          SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: _newsData
                                  .map((e) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: NewsCard(
                                            title: e["title"]!,
                                            time: e["time"]!,
                                            imageLink: e["imageLink"]!),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          SizedBox(height: sectionPadding),

          // ------- SETTINGS ----------
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, -0.2),
                ),
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0.2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                TitleWithButton(
                  title: "Settings",
                  isShowButton: false,
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    SettingRow(
                      text: "Change password",
                      subText: "",
                      color: Theme.of(context).primaryColor,
                      icon: Icons.lock,
                      onClick: () => mCtrler.setPage("ChangePassword"),
                    ),
                    SizedBox(height: 15),
                    SettingRow(
                      text: "Language",
                      subText: "English",
                      color: Colors.red,
                      icon: Icons.language,
                      onClick: () => {},
                    ),
                    SizedBox(height: 15),
                    SettingRow(
                      text: "Security",
                      subText: "Not enabled",
                      color: Colors.blue,
                      icon: Icons.security,
                      onClick: () => {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: sectionPadding),
          // ------- LEGAL POLICIES ----------

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, -0.2),
                ),
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0.2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                TitleWithButton(
                  title: "Legal and policies",
                  isShowButton: false,
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    SettingRow(
                      text: "Term of use",
                      subText: "",
                      color: Colors.blue,
                      icon: Icons.menu_book,
                      onClick: () => {},
                    ),
                    SizedBox(height: 15),
                    SettingRow(
                      text: "Complaints and Dispute resolution policy",
                      subText: "",
                      color: Theme.of(context).primaryColor,
                      icon: Icons.warning_rounded,
                      onClick: () => {},
                    ),
                    SizedBox(height: 15),
                    SettingRow(
                      text: "Private Policy",
                      subText: "",
                      color: Colors.red,
                      icon: Icons.privacy_tip_sharp,
                      onClick: () => {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: sectionPadding),
          // ------- FAQ ----------
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, -0.2),
                ),
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0.2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SettingRow(
              text: "FAQ",
              subText: "",
              color: Colors.grey.shade800,
              icon: Icons.question_answer,
              onClick: () => {},
            ),
          ),

          SizedBox(height: sectionPadding),

          // ------- LOG IN/OUT ------
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, -0.2),
                ),
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0.2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Obx(
              () => SettingRow(
                text: authController.isSignIn ? "Log out" : "Log in",
                subText: "",
                color: authController.isSignIn ? Colors.red : Colors.orange,
                icon: authController.isSignIn ? Icons.logout : Icons.login,
                onClick: () => authController.isSignIn
                    ? authController.signOut()
                    : Get.to(() => LoginPage()),
              ),
            ),
          ),
          SizedBox(height: sectionPadding),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 120);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 120);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
