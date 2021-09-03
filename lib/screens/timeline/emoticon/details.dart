import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  static String routeName = "/details";

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  dynamic ref = FirebaseFirestore.instance.collection('event');
  bool keyBoardState;

  List emotions = [
    ['super.svg', Colors.orange],
    ['smile.svg', Colors.red],
    ['no_exp.svg', Colors.blue],
    ['sad.svg', Colors.green],
    ['cry.svg', Colors.purple],
  ];

  String checkEmotion(String emotion) {
    for (var i = 0; i < emotions.length; i++) {
      if (emotion == emotions[i][0]) {
        return 'assets/icons/$emotion';
      }
    }
  }

  Color colorDecide(String emotion) {
    for (var i = 0; i < emotions.length; i++) {
      if (emotion == emotions[i][0]) {
        return emotions[i][1];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff1948AE),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Emoticon',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Map data = snapshot.data.docs[index].data();

                return data['user_id'] == 'icon'
                    ? Container(
                        width: 100,
                        height: 100,
                        child: Card(
                          color: colorDecide(data['title']),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: SvgPicture.asset(
                                    checkEmotion(
                                      data['title'],
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat("EEEE, dd MMMM, yyyy").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          data['date'])),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container();
              },
            );
          } else {
            return Center(
              child: Text('Loading...'),
            );
          }
        },
      ),
    );
  }
}
