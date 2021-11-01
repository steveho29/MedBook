import 'package:flutter/material.dart';

class PromotionScrollView extends StatefulWidget {
  final List<Map<String, String>> data;

  const PromotionScrollView({required this.data});

  @override
  _PromotionScrollViewState createState() => _PromotionScrollViewState();
}

class _PromotionScrollViewState extends State<PromotionScrollView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.data
              .map((e) => Padding(
                    padding: EdgeInsets.all(3),
                    child: PromotionCard(
                        time: e['time']!,
                        title: e['title']!,
                        place: e['place']!,
                        image: e['image']!),
                  ))
              .toList()),
    );
  }
}

class PromotionCard extends StatefulWidget {
  final String time, title, place, image;
  const PromotionCard(
      {required this.time,
      required this.title,
      required this.place,
      required this.image});

  @override
  _PromotionCardState createState() => _PromotionCardState();
}

class _PromotionCardState extends State<PromotionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // shadowColor: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                widget.image,
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.fill,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.place,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey.shade500),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Row(
                    children: [
                      Icon(Icons.card_giftcard_rounded, color: Colors.red),
                      Spacer(),
                      Text(
                        "Get deal",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
