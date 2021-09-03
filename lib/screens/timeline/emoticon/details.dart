import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/timeline/jurnal/add_jurnal.dart';

class Details extends StatefulWidget {
  static String routeName = "/details";

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  dynamic ref = FirebaseFirestore.instance.collection('event');
  bool keyBoardState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff1948AE),
        iconTheme: IconThemeData(color: Colors.white,),
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
                    ? Card(
                        color: Colors.amber[600],
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['title']}",
                                style: TextStyle(
                                  fontSize: 32.0,
                                  fontFamily: "lato",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
