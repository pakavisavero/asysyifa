import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/timeline/jurnal/add_jurnal.dart';
import 'package:shop_app/screens/timeline/jurnal/view_jurnal.dart';

class JurnalHarian extends StatefulWidget {
  static String routeName = "/jurnal_harian";

  @override
  _JurnalHarianState createState() => _JurnalHarianState();
}

class _JurnalHarianState extends State<JurnalHarian> {
  QuillController _controller = QuillController.basic();

  dynamic ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes')
      .orderBy('crated', descending: true);
  bool keyBoardState;

  // List<Color> myColors = [
  //   Colors.yellow[200],
  //   Colors.red[200],
  //   Colors.green[200],
  //   Colors.deepPurple[200],
  //   Colors.purple[200],
  //   Colors.cyan[200],
  //   Colors.teal[200],
  //   Colors.tealAccent[200],
  //   Colors.pink[200],
  // ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, AddJurnal.routeName).then((value) {
            setState(() {});
          });
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(0xff1948AE),
        title: Text(
          'Jurnal Harian',
          style: GoogleFonts.lato(
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
                // Random random = new Random();
                // Color bg = myColors[random.nextInt(4)];
                Map data = snapshot.data.docs[index].data();
                DateTime mydateTime = data['crated'].toDate();
                String formattedTime =
                    DateFormat.yMMMd().add_jm().format(mydateTime);

                QuillController _controller = QuillController.basic();

                var myJSON = jsonDecode(data['description']);
                _controller = QuillController(
                    document: Document.fromJson(myJSON),
                    selection: TextSelection.collapsed(offset: 0));

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ViewNote(
                            data,
                            formattedTime,
                            snapshot.data.docs[index].reference,
                          );
                        },
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
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
                          SizedBox(height: 10),
                          Container(
                            width: size.width * 0.75,
                            child: QuillEditor.basic(
                              controller: _controller,
                              readOnly: true, // true for view only mode
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              DateFormat.yMMMd().add_jm().format(mydateTime),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
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
