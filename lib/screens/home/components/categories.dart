import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/features/events/data/services/event_firestore_service.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/super.svg",
        "text": "Keren!",
        "ket": "super.svg",
      },
      {
        "icon": "assets/icons/smile.svg",
        "text": "Baik",
        "ket": "smile.svg",
      },
      {
        "icon": "assets/icons/no_exp.svg",
        "text": "Biasa",
        "ket": "no_exp.svg",
      },
      {
        "icon": "assets/icons/sad.svg",
        "text": "Buruk",
        "ket": "sad.svg",
      },
      {
        "icon": "assets/icons/cry.svg",
        "text": "Sangat buruk",
        "ket": "cry.svg"
      },
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () async {
              await eventDBS.create({
                "date": DateTime.now().millisecondsSinceEpoch,
                "public": false,
                "title": categories[index]["ket"],
                "user_id": "icon",
              });
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(12)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFF3F20AF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(height: 4),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
