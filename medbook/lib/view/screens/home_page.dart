// import 'dart:html';

import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/controller/main_controller.dart';
import 'package:medbook/view/widgets/card_with_menuicon.dart';
import 'package:medbook/view/widgets/covid_card.dart';
import 'package:medbook/view/widgets/covid_source_text.dart';
import 'package:medbook/view/widgets/hot_announcement.dart';
import 'package:medbook/view/widgets/image_slider.dart';
import 'package:medbook/view/widgets/menu_icon.dart';
import 'package:medbook/view/widgets/news_card.dart';
import 'package:medbook/view/widgets/promotion_card.dart';
import 'package:medbook/view/widgets/title_with_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.find();
  final MainPageController mainPageController = Get.find();
  List<String> _listImageSlider = [
    "assets/images/vinmecbanner.png",
    "assets/images/vinmecbanner.png",
    "assets/images/vinmecbanner.png"
  ];
  List<Map<String, String>> _promotionData = [
    {
      'time': "From 25/10 - 31/10, 2021",
      'title': "Promotion at Fertility preservation Webinar ",
      'place': "VINMEC TIMES CITY, HANOI ",
      'image': "assets/images/promotion2.jpg",
    },
    {
      'time': "From 25/10 - 31/10, 2021",
      'title': "Promotion at Fertility preservation Webinar ",
      'place': "VINMEC TIMES CITY, HANOI ",
      'image': "assets/images/thaisan.jpg",
    },
    {
      'time': "From 25/10 - 31/10, 2021",
      'title': "Promotion at Fertility preservation Webinar ",
      'place': "VINMEC TIMES CITY, HANOI ",
      'image': "assets/images/promotion3.png",
    },
  ];
  List<String> _hotAnnouncement = [
    "Ra mắt Khoá học trực tuyến \"Thai kỳ khoẻ mạnh cùng chuyên gia Vinmec\"",
    "Ra mắt Khoá học trực tuyến \"Thai kỳ khoẻ mạnh cùng chuyên gia Vinmec\"",
  ];
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
    {
      "title": "Liverpool vùi dập Man Utd ngay tại Old Trafford ",
      "time": "29/10/2001",
      "imageLink":
          "https://cdn-img.thethao247.vn/origin_865x0/storage/files/anhtuan/2021/10/24/truc-tiep-mu-0-3-liverpool-qua-nhanh-qua-nguy-hiem-83139.jpg",
    },
    {
      "title": "Giá Bitcoin lao dốc, thời điểm thử thách độ liều dân chơi",
      "time": "29/10/2001",
      "imageLink": "https://vnn-imgs-f.vgcloud.vn/2021/10/27/09/bitcoin-1.jpg",
    },
    {
      "title": "Vy khung",
      "time": "29/10/2001",
      "imageLink":
          "https://scontent.fsgn4-1.fna.fbcdn.net/v/t1.6435-9/83190275_2535404480052298_8389724558352973824_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=174925&_nc_ohc=1wZOzYV9UywAX9eZJnT&_nc_ht=scontent.fsgn4-1.fna&oh=a719726df0a29c9b5076dfcaf90c3f0c&oe=619FD1D7",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(60),
                bottomEnd: Radius.circular(60),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MyMedBook",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 40) * 0.8,
                            child: Text(
                              "We care with compassion, professionalism ...",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      // Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(30),
                      //       color: Colors.white,
                      //     ),
                      //     child: IconButton(
                      //         onPressed: () => {}, icon: Icon(Icons.search))),
                      GestureDetector(
                        onTap: () => mainPageController.setPage("Account"),
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: authController.isSignIn &&
                                    authController.user.photoURL != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      authController.user.photoURL!,
                                      fit: BoxFit.fitWidth,
                                      width: 50,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/avatar.svg',
                                    width: 50,
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.center,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: ImageSlider(listImages: this._listImageSlider),
                ),

                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor,
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ]),
                  child: GridView.count(
                    padding: EdgeInsets.all(20),
                    primary: false,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    mainAxisSpacing: 0,
                    children: [
                      MenuIcon(
                        name: "Appoinment",
                        menuIcon: Icon(Icons.calendar_today_outlined),
                        onClick: () => mainPageController.setPage("Booking"),
                      ),
                      MenuIcon(
                        name: "Hotline",
                        menuIcon: Icon(Icons.settings_phone),
                        onClick: () => {},
                      ),
                      MenuIcon(
                          onClick: () => {},
                          name: "Vaccine",
                          menuIcon:
                              FaIcon(FontAwesomeIcons.handHoldingMedical)),
                      MenuIcon(
                          onClick: () => {},
                          name: "Service",
                          menuIcon: Icon(Icons.medical_services)),
                      MenuIcon(
                          onClick: () => {},
                          name: "Donate",
                          menuIcon: FaIcon(FontAwesomeIcons.donate)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // ----------- BANNER WITH BOOKING BUTTON----------------

                GestureDetector(
                  onTap: () => {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("assets/images/vinmecbanner.png"),
                  ),
                ),

                SizedBox(height: 20),
                // ----------- PROMOTION ----------------
                TitleWithButton(title: "Promotion"),
                SizedBox(height: 15),
                PromotionScrollView(data: this._promotionData),
                SizedBox(height: 20),

                // ----------- HOT ANNOUNCEMENT ----------------
                TitleWithButton(title: "Hot announcement"),
                SizedBox(height: 20),
                HotAnnouncement(data: _hotAnnouncement),
                SizedBox(height: 20),

                // ----------- NEWS ----------------
                TitleWithButton(title: "News"),
                SizedBox(height: 20),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   padding: EdgeInsets.all(0),
                // child:
                Row(
                  children: [
                    Expanded(
                      child: CardWithMenuIcon(
                        name: "Hot News",
                        menuIcon: FaIcon(FontAwesomeIcons.newspaper),
                      ),
                    ),
                    Expanded(
                      child: CardWithMenuIcon(
                        name: "For Customers",
                        menuIcon: FaIcon(FontAwesomeIcons.handHoldingHeart),
                      ),
                    ),
                    Expanded(
                      child: CardWithMenuIcon(
                        name: "About Us",
                        menuIcon: FaIcon(FontAwesomeIcons.facebook),
                      ),
                    ),
                  ],
                ),
                // ),
                SizedBox(height: 20),

                TitleWithButton(title: "Latest News"),
                SizedBox(height: 20),

                Column(
                  children: _newsData
                      .map((e) => NewsCard(
                          title: e["title"]!,
                          time: e["time"]!,
                          imageLink: e["imageLink"]!))
                      .toList(),
                ),
                SizedBox(height: 20),

                // ----------- COVID CASES ----------------

                TitleWithButton(title: "Covid - 19"),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: CovidCard(isVN: true),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: CovidCard(isVN: false),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CovidSourceText(time: "17:50, 29/10/2021"),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
